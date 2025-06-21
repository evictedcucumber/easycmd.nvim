local json_path = vim.fn.stdpath('data') .. '/easycmd/commands.json'

local M = {}

--- Write the current commands to commands.json
---
---@param commands easycmd.PathRelatedEntry[]
---@return nil
M.write = function(commands)
    local encode_ok, json = pcall(vim.json.encode, commands)
    if not encode_ok then
        vim.notify('Unable to encode commands as json', vim.log.levels.ERROR)
        return
    end

    local json_dir = vim.fn.fnamemodify(json_path, ':h')
    if vim.fn.isdirectory(json_dir) == 0 then
        vim.fn.mkdir(json_dir, 'p')
    end

    local lines = vim.fn.split(json, '\n')
    local write_ok, _ = pcall(vim.fn.writefile, lines, json_path)
    if not write_ok then
        vim.notify(
            'Unable to write commands to json file',
            vim.log.levels.ERROR
        )
        return
    end
end

---@return easycmd.PathRelatedEntry[] paths The list of paths and their realted commands
M.read = function()
    if vim.fn.filereadable(json_path) == 0 then
        return {}
    end

    local read_ok, lines = pcall(vim.fn.readfile, json_path)
    if not read_ok then
        vim.notify('Unable to read commands.json', vim.log.levels.ERROR)
        return {}
    end

    local json = table.concat(lines, '\n')
    local decode_ok, paths = pcall(vim.json.decode, json)
    if not decode_ok then
        vim.notify('Unable to decode json', vim.log.levels.ERROR)
        return {}
    end

    return paths
end

return M
