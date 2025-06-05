local util = require('easycmd.util')
local state = require('easycmd.state')

local M = {}

M.setup = function(opts)
    opts = opts or {}
    state.config = opts
end

--- Edit the command at the given index
---
--- Will run the command on accepting the edit. Will also always run the command a floating window
---
---@param idx number The index of the command to edit
---@return nil
M.edit_command = function(idx)
    local current_command = ''
    for _, entry in ipairs(state.commands) do
        if entry.idx == idx then
            current_command = entry.command
        end
    end
    vim.ui.input(
        { prompt = 'Edit Command [' .. idx .. ']', default = current_command },
        function(input)
            if not input then
                return
            end
            util.run_command(input, 'float')
            util.change_command(idx, input)
        end
    )
end

--- Run the command at the given index
---
---@param idx number The index of the command to run
---@param win_type 'float'|'tab' The type of window to run the command in
---@return nil
M.run_command = function(idx, win_type)
    for _, entry in ipairs(state.commands) do
        if entry.idx == idx then
            util.run_command(entry.command, win_type)
            return
        end
    end
    print('No command at index ' .. idx)
end

M.list_commands = function()
    local output = ''
    for _, entry in ipairs(state.commands) do
        output = output .. entry.idx .. ': "' .. entry.command .. '"\n'
    end
    print(output)
end

return M
