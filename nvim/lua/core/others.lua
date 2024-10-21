-- Others
vim.api.nvim_create_user_command('PackageInfo',
    function(opts)
        require('package-info').show({ force = true })
    end, {
        nargs = 0
    }
)

-- Restore cursor position
local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
    "BufReadPost",
    {
        callback = function()
            local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
            if { row, col } ~= { 0, 0 } then
                vim.api.nvim_win_set_cursor(0, { row, 0 })
            end
        end,
        group = group
    }
)

-- Close all floating windows
vim.api.nvim_create_user_command('ForceCloseFloat',
    function(opts)
        local closed_windows = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= "" then  -- is_floating_window?
                vim.api.nvim_win_close(win, false)  -- do not force
                table.insert(closed_windows, win)
            end
        end
        print(string.format('Closed %d windows: %s', #closed_windows, vim.inspect(closed_windows)))
    end, {
        nargs = 0
    }
)
