--[[ https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/ ]]
require('opts')
require('keys')
require('packer_bootstrap')
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- packer itself. Prevents removal on sync

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end


    use 'nvim-treesitter/nvim-treesitter'
    use 'tpope/vim-fugitive'
    use 'mbbill/undotree'

    use {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim'
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Rust-specific plugins
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'
    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'
    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'

    use 'voldikss/vim-floaterm'
    use 'kyazdani42/nvim-tree.lua'
    -- Aesthetics
    use 'nvim-lualine/lualine.nvim' -- Statusline
    use 'kyazdani42/nvim-web-devicons' -- File icons
    use 'gruvbox-community/gruvbox' -- Theme

    -- shows hints on added, changed or removed lines from git diff
    use 'airblade/vim-gitgutter'
    -- moving between tmux tabs with <C-hjkl>
    use 'christoomey/vim-tmux-navigator'
end)
require('plug')
