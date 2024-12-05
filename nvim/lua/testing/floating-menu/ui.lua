local M = {}

-- 区切り線をウィンドウサイズに合わせて作成
function M.create_separator(width)
    return string.rep("─", width - 2) -- 両端の余白を考慮
end

-- 行を構成
function M.build_lines(config, path, sections, window_width)
    local padding = config.padding or 2
    local content_width = window_width - (padding * 2)
    local lines = {}

    -- パンくずリスト
    table.insert(lines, "%#MenuTitle#" .. string.rep(" ", padding) .. " " .. table.concat(path, "  "))
    table.insert(lines, "")

    -- タイトル
    table.insert(lines, "%#MenuTitle#" .. string.rep(" ", padding) .. " " .. (config.title or "Menu"))
    table.insert(lines, "")

    -- セクションとアイテム
    for _, section in ipairs(sections) do
        if section.title then
            table.insert(lines, "%#MenuSection#" .. string.rep(" ", padding) .. " " .. section.title)
        end
        for _, item in ipairs(section.items) do
            local icon = item.icon and ("%#MenuItem#" .. item.icon .. " ") or "   "
            local text = "%#MenuItem#" .. item.text
            local key = item.key and ("%#MenuKey#" .. item.key) or ""

            -- 左側アイコン + 中央タイトル + 右側キーの整列
            local line_with_key = string.format(
                "%-" .. content_width .. "s%s",
                string.rep(" ", padding) .. icon .. text,
                key
            )
            table.insert(lines, line_with_key)
        end

        -- セクション間の区切り線
        table.insert(lines, "%#MenuSeparator#" .. string.rep(" ", padding) .. M.create_separator(content_width))
    end

    return lines
end

-- バッファとウィンドウを作成
function M.create_menu_window(config, lines)
    local width = config.width or 50
    local height = #lines
    local ui = vim.api.nvim_list_uis()[1]
    local row = math.floor((ui.height - height) / 2)
    local col = math.floor((ui.width - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)

    -- 行をバッファに設定
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- ウィンドウ作成
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    return buf, win
end

return M
