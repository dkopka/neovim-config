vim.g.mapleader = ","
vim.g.localleader = "\\"
-- move around splits within neovim
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', {})
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', {})
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', {})
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', {})

local wk_found, which_key = pcall(require, "which-key")
if not  wk_found then
  vim.notify("which-key module not found!", vim.log.levels.ERROR)
  return
end

local function opts(module, desc)
    return { desc = module .. ": " .. desc, noremap = true, silent = true, nowait = true }
end

-- [[ telescope ]] --
local tb = require('telescope.builtin')
which_key.add( {'<leader>f', group = "Find file or strings with Telescope" })
vim.keymap.set('n', '<leader>ff', tb.find_files, opts("Telescope","Find File"))
vim.keymap.set('n', '<leader>fg', tb.live_grep, opts("Telescope","Live Grep"))
vim.keymap.set('n', '<leader>fs', tb.grep_string, opts("Telescope","Grep String"))
vim.keymap.set('n', '<leader>fb', tb.buffers, opts("Telescope","Get Buffers"))
vim.keymap.set('n', '<leader>fh', tb.help_tags, opts("Telescope","Grep in Help Tags"))
vim.keymap.set('n', '<leader>fd', tb.current_buffer_fuzzy_find, opts("Telescope","Grep in current buffer"))
vim.keymap.set('n', '<leader>fF', function()
    tb.find_files({
        no_ignore = true,
        hidden = true,
    })
end, opts("Telescope","Find File (also in hidden)"))
vim.keymap.set('n', '<leader>fG', function()
    tb.live_grep({
        additional_args = function()
            return { '--no-ignore' }
        end,
    })
end, opts("Telescope","Live Grep (also in hidden)"))

-- [[ NvimTree ]] --
vim.keymap.set('n', '<C-b>', vim.cmd.NvimTreeToggle, {})
-- [[ mbbill/undotree ]] --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {})


local opts_empty = { noremap=true, silent=true }

vim.keymap.set('n', '<C-x>',  '<Cmd>q<CR>', opts_empty)
-- [[ tab-page ]] --
vim.keymap.set('n', '<C-t>',  '<Cmd>tabnew<CR>', opts_empty)

-- [[ lsp ]] --
vim.keymap.set('n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>', opts_empty)
vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts_empty)
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts_empty)
vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts_empty)
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts_empty)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts_empty)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts_empty)
vim.keymap.set('n', '<leader>d',  '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts_empty)
vim.keymap.set('n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts_empty)
vim.keymap.set('n', '<leader>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts_empty)
--vim.keymap.set('n', '<leader>f',  '<cmd>lua vim.lsp.buf.format()<cr>', opts_empty)
vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts_empty)
vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts_empty)
vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts_empty)
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts_empty)

-- [[ ibl - indent-blankline ]] --
vim.keymap.set('n', '<leader>i', '<cmd>IBLToggle<cr>', opts("IndentBlankline", "Toggle indent leading lines"))
-- [[ builtin visuals ]] --
vim.keymap.set('n', '<leader>n', '<cmd>set invnumber<cr><cmd>set invrelativenumber<cr>', opts("Numbers", "Toggle line number visibility"))

-- [[ git ]] --
vim.keymap.set('n', ']c', '<cmd>GitGutterNextHunk<CR>', opts("GitGutter", "Jump to Next Hunk"))
vim.keymap.set('n', '[c', '<cmd>GitGutterPrevHunk<CR>', opts("GitGutter", "Jump to Previous Hunk"))
which_key.add( {'<leader>g', group = "Git related functions with GitGutter" })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', opts("GitGutter", "Show Git Blame"))
-- vim.keymap.set('n', '<leader>gl', function() vim.cmd('Git log ' .. vim.fn.expand('<cword>')) end, opts("GitGutter", "Show git log"))
vim.keymap.set('n', '<leader>gl', function()
    local word = vim.fn.expand('<cword>')
    local is_commit = string.match(word, '^%x%x%x%x%x%x%x+')
        vim.cmd('leftabove vsp')
    if is_commit then
        vim.cmd('terminal git log' .. word)
    else
        vim.cmd('terminal git log')
    end
end, opts("git", "git log <cword>"))

-- vim.keymap.set('n', '<leader>gs', function() vim.cmd('Git show ' .. vim.fn.expand('<cword>')) end, opts("GitGutter", "Show commit under cursor"))
vim.keymap.set('n', '<leader>gs', function()
    local sha = vim.fn.expand('<cword>')
    vim.cmd('vsp | terminal git show ' .. sha)
    vim.cmd('startinsert')
end, opts("git", "show commit's log"))
vim.keymap.set('n', '<leader>gr', function() vim.cmd('!git restore %') end, opts("GitGutter", "Git restore current file"))
vim.keymap.set('n', '<leader>gu', function() vim.cmd('!git restore --staged %') end, opts("GitGutter", "Git unstage current file"))

which_key.add( {'<leader>gv', group = "GitGutter visual control" })
vim.keymap.set('n', '<leader>gvh', '<cmd>GitGutterLineHighlightsToggle<CR>',    opts("GitGutter", "Toggle Line Highlights"))
vim.keymap.set('n', '<leader>gvn', '<cmd>GitGutterLineNrHighlightsToggle<CR>',  opts("GitGutter", "Toggle Line Numbers Highlights"))
vim.keymap.set('n', '<leader>gvt', '<cmd>GitGutterToggle<CR>',                  opts("GitGutter", "Toggle Enable"))
vim.keymap.set('n', '<leader>gvf', '<cmd>GitGutterFold<CR>',                    opts("GitGutter", "Fold unchanged"))

which_key.add( {'<leader>gh', group = "Git Hunks Operations" })
vim.keymap.set('n', '<leader>ghp', '<cmd>GitGutterPreviewHunk<CR>', opts("GitGutter", "Preview Hunk"))
vim.keymap.set('n', '<leader>ghs', '<cmd>GitGutterStageHunk<CR>', opts("GitGutter", "Stage this Hunk"))
vim.keymap.set('n', '<leader>ghu', '<cmd>GitGutteUndoHunk<CR>', opts("GitGutter", "Undo this Hunk"))

-- [[ undotree ]] --
-- which_key.add( {'<leader>u', group = "UndoTree controls" })
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', opts("UndoTree", "Show undotree"))
