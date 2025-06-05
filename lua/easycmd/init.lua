local _util = require('easycmd.util')
local state = require('easycmd.state')

local M = {}

--- Edit the command at the given index
---
--- Will run the command on accepting the edit
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
            _util.run_command(input)
            _util.change_command(idx, input)
        end
    )
end

--- Run the command at the given index
---
---@param idx number The index of the command to run
---@return nil
M.run_command = function(idx)
    for _, entry in ipairs(state.commands) do
        if entry.idx == idx then
            _util.run_command(entry.command)
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
