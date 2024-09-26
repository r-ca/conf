-- TUI utilities
local M = {}

local Terminal = require('toggleterm.terminal').Terminal

-- LazyDocker
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function M.LazyDockerToggle()
    lazydocker:toggle()
end

-- LazyGit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function M.LazyGitToggle()
    lazygit:toggle()
end

return M
