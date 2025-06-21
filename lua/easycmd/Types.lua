---@class easycmd.Entry
---@field idx integer The index of the command
---@field command string The command

---@class easycmd.PathRelatedEntry
---@field path string The path representing the list of commands
---@field commands easycmd.Entry[] The commands for the specified path

---@alias easycmd.win_type
---|'float' A floating window
---|'tab' A new tab
---|'hsplit' A horizontal split
---|'vsplit' A vertical split

---@class easycmd.config.Window
---@field close_key? string The key used to close a term window
---@field default_type easycmd.win_type The type of window created by default

---@class easycmd.config.Run
---@field window? easycmd.config.Window The specific window config

---@class easycmd.config.Edit
---@field window? easycmd.config.Window The specific window config

---@class easycmd.Config
---@field window? easycmd.config.Window The specific window config
---@field run? easycmd.config.Run The run specific settings
---@field edit? easycmd.config.Edit The edit specific settings
