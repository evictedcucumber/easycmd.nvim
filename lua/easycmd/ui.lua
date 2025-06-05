local M = {}

---@class easycmd.ui.UIElement
---@field buf integer The buffer id
---@field win integer The win id

--- Create a floating window with buffer and return the win and buf numbers.
---
---@param win_config? vim.api.keyset.win_config The window configuration
---@return easycmd.ui.UIElement float The buf and win numbers of the created window
M.create_new_float = function(win_config)
    win_config = win_config or {}

    win_config.width = win_config.width or math.floor(vim.o.columns * 0.9)
    win_config.height = win_config.height or math.floor(vim.o.lines * 0.9)
    win_config.row = win_config.row or math.floor((vim.o.lines - win_config.height) / 2)
    win_config.col = win_config.col or math.floor((vim.o.columns - win_config.width) / 2)

    win_config.relative = win_config.relative or 'editor'
    win_config.style = win_config.style or 'minimal'
    win_config.border = win_config.border or 'rounded'

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

--- Create a new tab and return its buffer number
---@return easycmd.ui.UIElement tab The tab info of the new buffer and window
M.create_new_tab = function()
    vim.cmd('tabnew')

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()

    return { buf = buf, win = win }
end

---@param type 'hsplit'|'vsplit' The type of split to create
---@return easycmd.ui.UIElement
M.create_new_split = function(type)
    if type == 'hsplit' then
        vim.cmd('split')
    elseif type == 'vsplit' then
        vim.cmd('vsplit')
    end

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_win_set_buf(win, buf)

    return { buf = buf, win = win }
end

return M
