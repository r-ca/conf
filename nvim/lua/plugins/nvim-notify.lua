return {
    "rcarriga/nvim-notify",
    config = function()
        local nvim_notify = require("notify")
        nvim_notify.setup {
            -- Animation style
            stages = "fade_in_slide_out",
            -- Default timeout for notifications
            timeout = 1500,
            render = "compact"
        }
        vim.notify = nvim_notify
    end
}
