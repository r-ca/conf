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
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local config = vim.api.nvim_win_get_config(win)
            if config.relative ~= "" then  -- is_floating_window?
                vim.api.nvim_win_close(win, false)  -- do not force
            end
        end
    end, {
        nargs = 0
    }
)

vim.api.nvim_create_user_command('DismissNotify',
    function(opts)
        require('noice').cmd('dismiss')
    end, {
        nargs = 0
    }
)
