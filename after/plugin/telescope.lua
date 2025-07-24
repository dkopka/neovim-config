local telescope = require('telescope')
local builtin = require('telescope.builtin')

local function live_grep_including_ignored()
    builtin.live_grep({
        additional_args = function() return { '--no-ignore' } end
    })
end

