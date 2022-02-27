require('nvim-treesitter.configs').setup({
    ensure_installed = "maintained",
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
