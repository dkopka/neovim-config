-- custom
vim.keymap.set('n', '<C-h>', ":wincmd h<CR>", {})
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>", {})
vim.keymap.set('n', '<C-k>', ":wincmd k<CR>", {})
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>", {})

-- nvim-telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- mbbill/undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {})


