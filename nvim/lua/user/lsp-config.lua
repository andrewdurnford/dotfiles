-- Completions

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "path" },
        { name = 'luasnip' },
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
    documentation = {
  	    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0,'n','K','<cmd>lua vim.lsp.buf.hover()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gd','<cmd>lua vim.lsp.buf.definition()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','ga','<cmd>lua vim.lsp.buf.code_action()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gr','<cmd>lua vim.lsp.buf.references()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','gl', '<cmd>lua vim.diagnostic.open_float()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','rn','<cmd>lua vim.lsp.buf.rename()<CR>',opts)
    vim.api.nvim_buf_set_keymap(0,'n','ff', '<cmd>lua vim.lsp.buf.formatting()<CR>',opts)

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    end
end

-- Lsp Installer

local lsp_installer = require("nvim-lsp-installer")

local servers = {
    "cssls",
    "dockerls",
    -- "gopls",
    "graphql",
    "html",
    "jsonls",
    "prismals",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
}

for _, server_name in ipairs(servers) do
    local ok, server = lsp_installer.get_server(server_name)
    if ok and not server:is_installed() then
        lsp_installer.install(server.name)
    end
end

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "jsonls" then
        opts = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas()
                }
            }
        }
    end

    if server.name == "sumneko_lua" then
        opts = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        }
    end

    if server == "tsserver" then
        opts = {
            capabilities = capabilities,
            on_attach = function(client)
                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.document_range_formatting = false

                local ts_utils = require("nvim-lsp-ts-utils")
                ts_utils.setup({})
                ts_utils.setup_client(client)

                on_attach(client)
            end,
        }
    end

    -- if server == "yamlls" then
    --     opts = {
    --         capabilities = capabilities,
    --         on_attach = on_attach,
    --         settings = {
    --             yaml = {
    --                 schemas = require("schemastore").yaml.schemas()
    --             }
    --         }
    --     }
    -- end

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
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.stylelint,
    -- null_ls.builtins.formatting.stylelua,
}

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    diagnostics_format = "[#{c}] #{m} (#{s})",
})
