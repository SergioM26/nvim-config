require('nvim-treesitter').setup {
    ensure_installed = { 'vim', 'vimdoc', 'lua', 'cpp','qmljs','javascript','typescript','php'},

    auto_install = false,

    highlight = { enable = true },

    indent = { enable = true },
}
