require('telescope').setup{}
require('nvim-treesitter.configs').setup {
    highlight = { enable = true },
    ensure_installed = { "rust", "lua", "python" }
}
require('lspconfig').rust_analyzer.setup{}
