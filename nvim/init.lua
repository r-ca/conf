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
if vim.fn.has('mac') == 1 then
    vim.keymap.set('n', '<D-h>', ':wincmd h<CR>')
    vim.keymap.set('n', '<D-l>', ':wincmd l<CR>')
    vim.keymap.set('n', '<D-j>', ':wincmd j<CR>')
    vim.keymap.set('n', '<D-k>', ':wincmd k<CR>')
else
    vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
    vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
    vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
    vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
end

-- in terminal
if vim.fn.has('mac') == 1 then
    vim.keymap.set('t', '<D-h>', '<C-\\><C-N>:wincmd h<CR>')
    vim.keymap.set('t', '<D-l>', '<C-\\><C-N>:wincmd l<CR>')
    vim.keymap.set('t', '<D-j>', '<C-\\><C-N>:wincmd j<CR>')
    vim.keymap.set('t', '<D-k>', '<C-\\><C-N>:wincmd k<CR>')
else
    vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:wincmd h<CR>')
    vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:wincmd l<CR>')
    vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:wincmd j<CR>')
    vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:wincmd k<CR>')
end


-- LazyGit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'tg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
	"BufReadPost",
	{callback = function()
			local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
			if {row, col} ~= {0, 0} then
				vim.api.nvim_win_set_cursor(0, {row, 0})
			end
		end,
	group = group
	}
)
