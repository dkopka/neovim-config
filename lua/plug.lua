require('telescope').setup{}
require('nvim-treesitter.configs').setup {
    ensure_installed = { "rust", "lua", "python" },
    highlight = { enable = false },
}
