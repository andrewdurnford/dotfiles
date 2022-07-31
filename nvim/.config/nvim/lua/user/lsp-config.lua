-- Completions

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = "path" },
        { name = 'luasnip' },
    }, {
        { name = 'buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end
            }
        },
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                nvim_lua = "[lua]",
                emoji = "[emoji]",
                path = "[path]",
                calc = "[calc]",
                luasnip = "[snip]",
                buffer = "[buf]"
            })[entry.source.name]
            vim_item.dup = ({
                nvim_lsp = 1,
                path = 1,
                buffer = 0,
            })[entry.source.name] or 0
            return vim_item
        end
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- LspConfig

local servers = {
    "cssls",
    "dockerls",
    "gopls",
    "graphql",
    "html",
    "jsonls",
    "prismals",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
}

local on_attach = function(client)
    if client.name == 'tsserver' then
        -- disable formatting
        local callback = function()
            vim.lsp.buf.format({
                nil,
                -- bufnr = bufnr,
                filter = function()
                    return client.name == "null-ls"
                end
            })
        end

        -- setup ts-utils
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup {}
        ts_utils.setup_client(client)

        -- format on save
        vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ timeout_ms = 4000 })")
    end

    -- lsp remaps
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0,'n','K','<cmd>lua vim.lsp.buf.hover()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gd','<cmd>lua vim.lsp.buf.definition()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','ga','<cmd>lua vim.lsp.buf.code_action()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gr','<cmd>lua vim.lsp.buf.references()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gl', '<cmd>lua vim.diagnostic.open_float()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','rn','<cmd>lua vim.lsp.buf.rename()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','ff', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>',opts)
end

local server_opts = {
    ["jsonls"] = function(opts)
        opts.settings = {
            json = {
                schemas = require("schemastore").json.schemas()
            }
        }
    end,
    ["sumneko_lua"] = function(opts)
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    end,
}

-- Lsp Installer

local lsp_installer = require("nvim-lsp-installer")

-- Install language servers
for _, server_name in ipairs(servers) do
    local ok, server = lsp_installer.get_server(server_name)
    if ok and not server:is_installed() then
        lsp_installer.install(server.name)
    end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup lsp servers
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities
    }

    if server_opts[server.name] then
        server_opts[server.name](opts)
    end

    server:setup(opts)
end)

-- null-ls

local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.code_actions.gitsigns,

    null_ls.builtins.completion.luasnip,

    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.stylelint,

    -- null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.formatting.stylelua,
}

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    diagnostics_format = "[#{c}] #{m} (#{s})",
})
