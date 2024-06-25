vim.g.mapleader = ","
vim.g.localleader = "\\"
-- move around splits within neovim
vim.keymap.set('n', '<C-h>', ":wincmd h<CR>", {})
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>", {})
vim.keymap.set('n', '<C-k>', ":wincmd k<CR>", {})
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>", {})
-- nvim-telescope
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tb.find_files, {})
vim.keymap.set('n', '<leader>fg', tb.live_grep, {})
vim.keymap.set('n', '<leader>fs', tb.grep_string, {})
vim.keymap.set('n', '<leader>fb', tb.buffers, {})
vim.keymap.set('n', '<leader>fh', tb.help_tags, {})
vim.keymap.set('n', '<leader>g', tb.current_buffer_fuzzy_find, {})
-- NvimTree
vim.keymap.set('n', '<C-b>', vim.cmd.NvimTreeToggle, {})
-- mbbill/undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {})
