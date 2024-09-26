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

require('core.keymaps')

-- undo
vim.api.nvim_set_keymap('n', '<C-z>', '<cmd>undo<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>tabNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true, silent = true })

