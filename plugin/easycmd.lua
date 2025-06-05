local easycmd = require('easycmd')
local util = require('easycmd.util')

local usage = function()
    vim.notify('Usage: :EasyCmd <edit|run> [integer]', vim.log.levels.ERROR)
end

vim.api.nvim_create_user_command('EasyCmd', function(opts)
    local args = opts.fargs

    if #args < 1 then
        usage()
        return
    end

    local mode = args[1]
    if mode == 'list' then
        easycmd.list_commands()
        return
    end

    if #args < 2 then
        usage()
        return
    end

    local idx = tonumber(args[2])

    if not mode or not idx then
        usage()
        return
    end

    if mode == 'edit' then
        easycmd.edit_command(idx)
    elseif mode == 'run' then
        easycmd.run_command(idx)
    else
        vim.notify('Invalid mode `' .. mode .. '`', vim.log.levels.ERROR)
    end
end, {
    nargs = '+',
    complete = util.cmd_complete,
})
