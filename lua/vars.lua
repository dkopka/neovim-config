-- source: https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/

-- vim.o: maps to vim.api.nvim_win_set_var; sets variables scoped to a given window.
-- vim.b; maps to vim.api.nvim_buf_set_var; sets variables scoped to a given buffer.
-- vim.o: maps to vim.api.nvim_set_option; equivalent to :set.
-- vim.go: maps to vim.api.nvim_set_option; equivalent to :setglobal.
-- vim.bo; maps to vim.api.nvim_buf_set_option; equivalent to :setlocal for buffer options.
-- vim.wo: maps to vim.api.nvim_win_set_option; equivalent to :setlocal for window options.
-- 
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
