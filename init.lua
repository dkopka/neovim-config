local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local remove_after_dir_from_runtimepath = function()
    -- Get current runtimepath as a list.
    local rtp = vim.opt.runtimepath:get()

    -- Filter out any paths that match "after".
    local new_rtp = {}
    for _, path in ipairs(rtp) do
        if not path:match("/after$") then
            table.insert(new_rtp, path)
        end
    end

    -- Set the new runtimepath without those "after" directories.
    vim.opt.runtimepath = table.concat(new_rtp, ",")
end

local packer_bootstrap = ensure_packer()
if packer_bootstrap then
    print("Packer bootstrap!")
end

require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- packer itself. Prevents removal on sync

    use 'nvim-treesitter/nvim-treesitter'
    use 'tpope/vim-fugitive'
    use 'mbbill/undotree'

    use {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        "WhoIsSethDaniel/mason-tool-installer.nvim",
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

    use "folke/trouble.nvim"
    -- show key-bindings after pressing sequence start key
    use "folke/which-key.nvim"
    -- icons required by which-key
    use "echasnovski/mini.icons"

    -- https://github.com/lukas-reineke/indent-blankline.nvim
    -- show vertical lines to help read indents
    use "lukas-reineke/indent-blankline.nvim"

    if packer_bootstrap then
        vim.api.nvim_create_autocmd("User", {
            pattern = "PackerComplete",
            callback = function()
                print("Packer finished syncing!")
                vim.cmd("quitall")
            end,
        })
        -- While Packer is syncing sourcing ~/.config/nvim/lua/* and ~/.config/nvim/after/*
        -- files create a flood of errors. It only happens on bootstrap, but is confusing.
        -- Let's remove ~/.config/nvim/after* from being sourced on bootstrap.
        remove_after_dir_from_runtimepath()
        require('packer').sync()
    end
end)

-- Do not source files on first run (bootstrap)
if not packer_bootstrap then
    --[[ https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/ ]]
    require('opts')
    require('keys')

    require('plug')
    require('autocommands')
end
