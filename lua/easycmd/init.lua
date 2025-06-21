local util = require('easycmd.util')
local json = require('easycmd.json')
local state = require('easycmd.state')

local M = {}

M.setup = function(opts)
    opts = opts or {}
    state.config = opts

    state.paths = json.read()

    vim.api.nvim_create_autocmd('VimLeavePre', {
        group = vim.api.nvim_create_augroup(
            'easycmd_on_exit',
            { clear = true }
        ),
        once = true,
        callback = function()
            json.write(state.paths)
        end,
    })
end

--- Edit the command at the given index
---
--- Will run the command on accepting the edit. Will also always run the command a floating window
---
---@param idx number The index of the command to edit
---@return nil
M.edit_command = function(idx)
    local commands = util.get_commands_from_path()

    local current_command = ''
    for _, entry in ipairs(commands) do
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
            local win_type = (
                    state.config.window
                    and state.config.window.default_type
                )
                or
                (state.config.edit and state.config.edit.window and state.config.edit.window.default_type)
                or 'float'
            util.run_command(input, win_type)
            util.change_command(idx, input)
        end
    )
end

--- Run the command at the given index
---
---@param idx number The index of the command to run
---@param win_type easycmd.win_type The type of window to run the command in
---@return nil
M.run_command = function(idx, win_type)
    win_type = win_type
        or (state.config.window and state.config.window.default_type)
        or
        (state.config.run and state.config.run.window and state.config.run.window.default_type)
        or 'float'

    local commands = util.get_commands_from_path()

    for _, entry in ipairs(commands) do
        if entry.idx == idx then
            util.run_command(entry.command, win_type)
            return
        end
    end
    M.edit_command(idx)
end

---@param path? string The path to list the commands of
M.list_commands = function(path)
    path = path or vim.fn.getcwd()
    local output = 'path = ' .. path .. '\n'

    local commands = util.get_commands_from_path(path)

    for _, entry in ipairs(commands) do
        output = output .. entry.idx .. ': "' .. entry.command .. '"\n'
    end
    print(output)
end

--- Deletes the commands for the given path or cwd by default
---
---@param path string The path to delete the related commands from
M.delete_commands = function(path)
    path = path or vim.fn.getcwd()
    for i, path_entry in ipairs(state.paths) do
        if path_entry.path == path then
            table.remove(state.paths, i)
            return
        end
    end
end

return M
