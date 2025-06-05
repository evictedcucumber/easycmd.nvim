---@class easycmd.Entry
---@field idx integer The index of the command
---@field command string The command

---@class easycmd.PathRelatedEntry
---@field path string The path representing the list of commands
---@field commands easycmd.Entry[] The commands for the specified path

---@class easycmd.config.Window
---@field close_key? string The key used to close a term window

---@class easycmd.Config
---@field window? easycmd.config.Window The specific window config
