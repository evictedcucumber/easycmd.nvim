vim.api.nvim_create_user_command('EasyCmdRun', function(opts)
    local args = opts.fargs

    ---@return number|nil reg The number representing the register of the command to run.
    local get_reg = function()
        local reg = tonumber(args[1])
        if not reg then
            vim.notify(
                'Invalid <reg> expected a number but got `' .. args[1] .. '`.',
                vim.log.levels.ERROR)
            return
        end

        if reg < 1 then
            vim.notify(
                'Invalid <reg> expected a number > 1 but got `' .. reg .. '`.',
                vim.log.levels.ERROR)
            return
        end

        return reg
    end

    ---@return string|nil win_type The type of window to open when running the command.
    local get_win_type = function()
        local win_type = args[2]

        if not vim.list_contains({ 'tab', 'vsplit', 'hsplit', 'float' }, win_type) then
            vim.notify(
                'Invalid <win_type> expected "tab" | "float" | "hsplit" | "vsplit" but got `' ..
                win_type .. '`.', vim.log.levels.ERROR)
            return
        end

        return win_type
    end

    local usage = function()
        vim.notify('Usage: EasyCmdRun <reg> ["tab"|"float"|"hsplit"|"vsplit"]',
            vim.log.levels.ERROR)
    end

    -- Example: EasyCmdRun
    if #args < 1 then
        usage()

        return
    end

    -- Example: EasyCmdRun 1
    if #args == 1 then
        local reg = get_reg()

        if reg then
            require('easycmd').run_command(reg, 'float')
        else
            usage()
        end

        return
    end

    -- Example: EasyCmdRun 1 tab
    if #args == 2 then
        local reg = get_reg()
        local win_type = get_win_type()

        if reg and win_type then
            require('easycmd').run_command(reg, win_type)
        else
            usage()
        end

        return
    end
end, {
    nargs = '+',
    complete = require('easycmd.util').completionfuncs.run,
})

vim.api.nvim_create_user_command('EasyCmdRun', function(opts)
    local args = opts.fargs

    ---@return number|nil reg The number representing the register of the command to run.
    local get_reg = function()
        local reg = tonumber(args[1])
        if not reg then
            vim.notify(
                'Invalid <reg> expected a number but got `' .. args[1] .. '`.',
                vim.log.levels.ERROR)
            return
        end

        if reg < 1 then
            vim.notify(
                'Invalid <reg> expected a number > 1 but got `' .. reg .. '`.',
                vim.log.levels.ERROR)
            return
        end

        return reg
    end

    local usage = function()
        vim.notify('Usage: EasyCmdEdit <reg>',
            vim.log.levels.ERROR)
    end

    -- Example: EasyCmdEdit
    if #args < 1 then
        usage()

        return
    end

    -- Example: EasyCmdEdit 1
    if #args == 1 then
        local reg = get_reg()

        if reg then
            require('easycmd').edit_command(reg)
        else
            usage()
        end

        return
    end
end, {
    nargs = '+',
})
