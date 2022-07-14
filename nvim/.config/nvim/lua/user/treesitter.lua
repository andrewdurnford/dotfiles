require('nvim-treesitter.configs').setup({
    ensure_installed = "all",
    -- https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15
    ignore_install = { "phpdoc" },
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
