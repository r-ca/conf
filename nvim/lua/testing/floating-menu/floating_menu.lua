local ui = require("testing.floating-menu.ui")
local keymap = require("testing.floating-menu.keymap")

local M = {}
local history = {}



-- フローティングメニューを開く
function M.OpenFloatingMenu(config, path)
    config = config or {}
    local sections = config.sections or {}
    path = path or { config.title or "Menu" }

    table.insert(history, { config = config, path = path })

    -- 現在のウィンドウ幅を取得
    local ui_info = vim.api.nvim_list_uis()[1]
    local window_width = config.width or ui_info.width - 4 -- 両端の余白を考慮

    local lines = ui.build_lines(config, path, sections, window_width)
    local buf, win = ui.create_menu_window(config, lines)

    local item_line_map = {}
    local line_count = 4 -- パンくずリストとタイトル部分をスキップ
    for _, section in ipairs(sections) do
        if section.title then
            line_count = line_count + 1
        end
        for _, item in ipairs(section.items) do
            item_line_map[line_count] = item
            line_count = line_count + 1
        end
        line_count = line_count + 1
    end

    keymap.register_keymaps(buf, win, item_line_map, lines, {
        back = function()
            if #history > 1 then
                table.remove(history)
                local prev = history[#history]
                M.OpenFloatingMenu(prev.config, prev.path)
            end
        end,
    })
end

return M
