vim.g.mapleader = ","
vim.g.localleader = "\\"
-- move around splits within neovim
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', {})
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', {})
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', {})
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', {})

-- [[ telescope ]] --
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tb.find_files, {})
vim.keymap.set('n', '<leader>fg', tb.live_grep, {})
vim.keymap.set('n', '<leader>fs', tb.grep_string, {})
vim.keymap.set('n', '<leader>fb', tb.buffers, {})
vim.keymap.set('n', '<leader>fh', tb.help_tags, {})
vim.keymap.set('n', '<leader>g', tb.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fF', function()
    tb.find_files({
        no_ignore = true,
        hidden = true,
    })
end, {})
vim.keymap.set('n', '<leader>fG', function()
    tb.live_grep({
        additional_args = function()
            return { '--no-ignore' }
        end,
    })
end, {})

-- [[ NvimTree ]] --
vim.keymap.set('n', '<C-b>', vim.cmd.NvimTreeToggle, {})
-- [[ mbbill/undotree ]] --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {})


local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<C-x>',  '<Cmd>q<CR>', opts)
-- [[ tab-page ]] --
vim.keymap.set('n', '<C-t>',  '<Cmd>tabnew<CR>', opts)

-- [[ lsp ]] --
vim.keymap.set('n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
vim.keymap.set('n', '<leader>d',  '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
vim.keymap.set('n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
vim.keymap.set('n', '<leader>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
vim.keymap.set('n', '<leader>f',  '<cmd>lua vim.lsp.buf.format()<cr>', opts)
vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

-- [[ ibl - indent-blankline ]] --
vim.keymap.set('n', '<leader>i', '<cmd>IBLToggle<cr>', opts)
-- [[ builtin visuals ]] --
vim.keymap.set('n', '<leader>n', '<cmd>set invnumber<cr>', opts)

-- [[ git ]] --
vim.keymap.set('n', '<Tab><Tab>s', function() vim.cmd('Git show ' .. vim.fn.expand('<cword>')) end, opts)
vim.keymap.set('n', '<Tab><Tab>l', function() vim.cmd('Git log ' .. vim.fn.expand('<cword>')) end, opts)
vim.keymap.set('n', '<Tab><Tab>b', '<cmd>Git blame<CR>', opts)
-- the below is actually also handled by <leader>hs
vim.keymap.set('n', '<leader>gs', '<cmd>GitGutterStageHunk<CR>', opts)
vim.keymap.set('n', '<leader>gu', function() vim.cmd('!git restore --staged %') end, opts)
vim.keymap.set('n', '<leader>gr', function() vim.cmd('!git restore %') end, opts)
vim.keymap.set('n', '<leader>gc', function() vim.cmd('GitGutterLineHighlightsToggle') end, opts)
