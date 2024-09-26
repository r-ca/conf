local M = {}

---@class Options
---@field silent boolean(optional, default: true)
---@field noremap boolean(optional, default: true)

--モード定義
M.Mode = {
    NORMAL = 'n',        -- Normal
    INSERT = 'i',        -- Insert
    VISUAL = 'v',        -- Visual
    VISUAL_BLOCK = 'x',  -- Visual Block
    TERMINAL = 't',      -- Terminal
    COMMAND = 'c',       -- Command
}

---Set keymap
---@param mode @see Mode
---@param key string
---@param action string
---@param options Options (optional)
function M.set(mode, key, action, options)
    -- Modeが配列でない場合は配列に変換
    if type(mode) ~= 'table' then
        mode = { mode }
    end

    -- Optionsがnilの場合はデフォルト値
    options = options or { silent = true, noremap = true }

    -- Modeの数だけKeymapを設定
    for _, m in ipairs(mode) do
        vim.api.nvim_set_keymap(m, key, action, options)
    end
end

-- Wrappers

---Set keymap in Normal mode
---@param key string
---@param action string
---@param options Options (optional)
function M.normal(key, action, options)
    M.set(M.Mode.NORMAL, key, action, options)
end

---Set keymap in Insert mode
---@param key string
---@param action string
---@param options Options (optional)
function M.insert(key, action, options)
    M.set(M.Mode.INSERT, key, action, options)
end

---Set keymap in Visual mode
---@param key string
---@param action string
---@param options Options (optional)
function M.visual(key, action, options)
    M.set(M.Mode.VISUAL, key, action, options)
end

---set keymap in Visual Block mode
---@param key string
---@param action string
---@param options Options (optional)
function M.vblock(key, action, options)
    M.set(M.Mode.VISUAL_BLOCK, key, action, options)
end

---Set keymap in Terminal mode
---@param key string
---@param action string
---@param options Options (optional)
function M.terminal(key, action, options)
    M.set(M.Mode.TERMINAL, key, action, options)
end

---Set keymap in Command mode
---@param key string
---@param action string
---@param options Options (optional)
function M.command(key, action, options)
    M.set(M.Mode.COMMAND, key, action, options)
end

return M
