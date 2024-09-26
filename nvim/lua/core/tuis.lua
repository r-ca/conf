-- TUI utilities
local M = {}

local Terminal = require('toggleterm.terminal').Terminal

-- LazyDocker
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

local function _lazydocker_toggle()
    lazydocker:toggle()
end

function M.lazydocker_toggle()
    return _lazydocker_toggle
end

-- LazyGit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

local function _lazygit_toggle()
    lazygit:toggle()
end

function M.lazygit_toggle()
    return _lazygit_toggle
end

return M
