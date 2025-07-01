local state = require('easycmd.state')
local ui = require('easycmd.ui')

local M = {}

---@param path? string The path to check
---@return integer|nil idx The index of the found path or nil
local function path_exists(path)
    path = path or vim.fn.getcwd()
    for i, entry in ipairs(state.paths) do
        if entry.path == path then
            return i
        end
    end
end

M.__path_exists = function(path)
    return path_exists(path)
end

---@param idx integer The index of the command to insert or modify
---@param command string The command to put at the index
M.change_command = function(idx, command)
    local commands = M.get_commands_from_path()
    for _, entry in ipairs(commands) do
        if entry.idx == idx then
            entry.command = command
            return
        end
    end

    table.insert(commands, { idx = idx, command = command })
end

--- Run the given command
---
---@param command string The command to run
---@param win_type easycmd.win_type The type of window to create the terminal in
M.run_command = function(command, win_type)
    ---@type easycmd.ui.UIElement
    local out
    if win_type == 'float' then
        out = ui.create_new_float()
    elseif win_type == 'tab' then
        out = ui.create_new_tab()
    elseif win_type == 'vsplit' or win_type == 'hsplit' then
        ---@cast win_type 'vsplit'|'hsplit'
        out = ui.create_new_split(win_type)
    else
        vim.notify(
            'invaild win_type `' .. win_type .. '`',
            vim.log.levels.ERROR
        )
        return
    end

    vim.bo[out.buf].modifiable = false
    vim.bo[out.buf].buflisted = false

    local close_key = (state.config.window and state.config.window.close_key)
        or 'q'
    vim.keymap.set('n', close_key, function()
        vim.api.nvim_win_close(out.win, true)
        vim.api.nvim_buf_delete(out.buf, { force = true, unload = true })
    end, { buffer = out.buf })

    vim.api.nvim_set_current_win(out.win)

    vim.api.nvim_buf_call(out.buf, function()
        vim.fn.jobstart({
            'bash',
            '-c',
            command,
        }, {
            term = true,
        })
    end)

    vim.cmd('stopinsert')
end

---@class easycmd.CompletionFuncs
---@field run fun(arg_lead: string, cmd_line: string, cursor_pos: integer): string[] The completeion function for running commands.
M.completionfuncs = {}

---@param arg_lead string The leading portion of the argument currently being completed on
---@param cmd_line string The entire command line
---@param cursor_pos integer The cursor position in it
---@return string[] matches The completion options
M.completionfuncs.run = function(arg_lead, cmd_line, cursor_pos)
    local args = vim.split(cmd_line:sub(1, cursor_pos), '%s+')

    if #args == 2 then
        local suggestions = { 'float', 'tab', 'hsplit', 'vsplit' }
        local matches = {}
        for _, s in ipairs(suggestions) do
            if s:sub(1, #arg_lead) then
                table.insert(matches, s)
            end
        end

        return matches
    end

    return {}
end

---@param path? string The path to get the commands from or nil
---@return easycmd.Entry[] commands The commands related to the cwd
M.get_commands_from_path = function(path)
    path = path or vim.fn.getcwd()
    local idx = path_exists(path)
    if idx then
        return state.paths[idx].commands
    else
        table.insert(state.paths, { path = path, commands = {} })
        return state.paths[#state.paths].commands
    end
end

return M
