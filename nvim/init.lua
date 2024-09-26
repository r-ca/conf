-- load common settings
vim.cmd("source ~/.config/common.vim")

-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- set termguicolors
vim.opt.termguicolors = true

-- Load plugins dir
require('lazy').setup({
    spec = {
        { import = "plugins" },
        { import = "lsp" },
        { import = "lsp.lang" },
        { import = "colors" }
    }
})

-- set colorscheme
vim.cmd('colorscheme ayu')


-- undo
vim.api.nvim_set_keymap('n', '<C-z>', '<cmd>undo<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>tabNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true, silent = true })

-- AddCommands
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
