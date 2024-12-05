local M = {}

function M.register_keymaps(buf, win, item_line_map, lines, callbacks)
    local function move_cursor(direction)
        local current_line = vim.api.nvim_win_get_cursor(win)[1]
        repeat
            current_line = current_line + direction
            if current_line < 1 or current_line > #lines then return end
        until item_line_map[current_line] ~= nil
        vim.api.nvim_win_set_cursor(win, { current_line, 0 })
    end

    vim.api.nvim_buf_set_keymap(buf, "n", "j", "", {
        callback = function() move_cursor(1) end,
        noremap = true,
        silent = true,
    })

    vim.api.nvim_buf_set_keymap(buf, "n", "k", "", {
        callback = function() move_cursor(-1) end,
        noremap = true,
        silent = true,
    })

    vim.api.nvim_buf_set_keymap(buf, "n", "<Space>", "", {
        callback = function()
            local current_line = vim.api.nvim_win_get_cursor(win)[1]
            local item = item_line_map[current_line]
            if item and item.action then
                item.action()
                vim.api.nvim_win_close(win, true)
            end
        end,
        noremap = true,
        silent = true,
    })

    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
        callback = function()
            local current_line = vim.api.nvim_win_get_cursor(win)[1]
            local item = item_line_map[current_line]
            if item and item.action then
                item.action()
                vim.api.nvim_win_close(win, true)
            end
        end,
        noremap = true,
        silent = true,
    })

    if callbacks and callbacks.back then
        vim.api.nvim_buf_set_keymap(buf, "n", "b", "", {
            callback = function() callbacks.back() end,
            noremap = true,
            silent = true,
        })
    end

    vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
        callback = function() vim.api.nvim_win_close(win, true) end,
        noremap = true,
        silent = true,
    })
end

return M
