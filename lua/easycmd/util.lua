local state = require('easycmd.state')

local M = {}

---@param idx integer The index of the command to insert or modify
---@param command string The command to put at the index
M.change_command = function(idx, command)
    for _, entry in ipairs(state.commands) do
        if entry.idx == idx then
            entry.command = command
            return
        end
    end

    table.insert(state.commands, { idx = idx, command = command })
end

--- Run the given command
---
---@param command string The command to run
---@return nil
M.run_command = function(command)
    local float = require('easycmd.win').create_floating_window()
    local term = vim.api.nvim_open_term(float.buf, {})

    local function on_output(_, data, _)
        if not data then
            return
        end

        for _, line in ipairs(data) do
            vim.api.nvim_chan_send(term, line .. '\r\n')
        end
    end

    vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = on_output,
        on_stderr = on_output,
        on_exit = function()
            vim.api.nvim_chan_send(term, '\r\n[Press q to close]\r\n')
        end,
    })

    vim.cmd('stopinsert')
end

---@param arg_lead string The leading portion of the argument currently being completed on
---@param cmd_line string The entire command line
---@param cursor_pos integer The cursor position in it
---@return string[] matches The completion options
M.cmd_complete = function(arg_lead, cmd_line, cursor_pos)
    local args = vim.split(cmd_line:sub(1, cursor_pos), '%s+')

    if #args == 2 then
        local suggestions = { 'edit', 'run', 'list' }
        local matches = {}
        for _, s in ipairs(suggestions) do
            if s:sub(1, #arg_lead) then
                table.insert(matches, s)
            end
        end

        return matches
    else
        return {}
    end
end

return M
