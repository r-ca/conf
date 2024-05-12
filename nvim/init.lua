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

-- Keymaps
-- Window navigation
-- in normal
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')

-- in terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:wincmd h<CR>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:wincmd l<CR>')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:wincmd j<CR>')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:wincmd k<CR>')
