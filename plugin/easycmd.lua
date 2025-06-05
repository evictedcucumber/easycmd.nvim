local easycmd = require('easycmd')
local util = require('easycmd.util')

local usage = function()
    vim.notify('Usage: :EasyCmd <edit|run|list> [integer] [float|tab]', vim.log.levels.ERROR)
end

vim.api.nvim_create_user_command('EasyCmd', function(opts)
    local args = opts.fargs

    if #args < 1 then
        usage()
        return
    end

    if #args == 1 then
        local mode = args[1]
        if mode == 'list' then
            easycmd.list_commands()
            return
        end
    end

    if #args == 2 then
        local mode = args[1]
        local param = args[2]

        if not mode or not param then
            usage()
            return
        end

        if mode == 'edit' then
            local idx = tonumber(param)
            if idx then
                easycmd.edit_command(idx)
            end
        elseif mode == 'run' then
            local idx = tonumber(param)
            if idx then
                easycmd.run_command(idx, 'float')
            end
        elseif mode == 'list' then
            easycmd.list_commands(param)
        else
            vim.notify('Invalid mode `' .. mode .. '`', vim.log.levels.ERROR)
        end
    end

    if #args == 3 then
        local mode = args[1]
        local idx = tonumber(args[2])
        local win_type = args[3]

        if not mode or not idx or not win_type then
            usage()
            return
        end

        if mode == 'run' then
            easycmd.run_command(idx, win_type)
        else
            vim.notify(
                'Invaild mode `' .. mode .. '` that accepts win_type `' .. win_type .. '`',
                vim.log.levels.ERROR
            )
            return
        end
    end
end, {
    nargs = '+',
    complete = util.cmd_complete,
})
