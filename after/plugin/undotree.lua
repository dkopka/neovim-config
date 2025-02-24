vim.cmd([[
let g:undotree_WindowLayout=3
let g:undotree_CustomUndotreeCmd = 'vertical 40 new'
let g:undotree_CustomDiffpanelCmd = 'belowright 10 new'
let g:undotree_SetFocusWhenToggle = 1
let g:undofile = 1
]])

if vim.fn.has("persistent_undo") == 1 then
    local target_path = vim.fn.expand("~/.undodir")

    -- Create directory if it doesn't exist
    if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "p", "0700")
    end

    -- Set undodir and enable undo file persistence
    vim.o.undodir = target_path
    vim.o.undofile = true
end

