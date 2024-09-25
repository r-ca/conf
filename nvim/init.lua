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

-- Keymaps
-- Window navigation
-- in normal
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { silent = true })

-- in terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:wincmd h<CR>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:wincmd l<CR>')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:wincmd j<CR>')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:wincmd k<CR>')

-- undo
vim.api.nvim_set_keymap('n', '<C-z>', '<cmd>undo<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>tabNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>tabnew<CR>', { noremap = true, silent = true })

-- LSP Action(Workaround)
vim.api.nvim_set_keymap('n', '<Space>', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<CR>', '<cmd>Lspsaga signature_help<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>Lspsaga rename<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gh', '<cmd>Lspsaga finder<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ga', '<cmd>Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gs', '<cmd>Lspsaga show_line_diagnostics<CR>', { noremap = true, silent = true })
-- format
vim.api.nvim_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-CR>', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Clipboard
vim.api.nvim_set_keymap('n', 'cp', '"*p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cy', '"*y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'cy', '"*y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'cp', '"*p', { noremap = true, silent = true })

-- AddCommands
vim.api.nvim_create_user_command('PackageInfo',
    function(opts)
        require('package-info').show({ force = true })
    end, {
        nargs = 0
    }
)

-- TUI Utils
local Terminal = require('toggleterm.terminal').Terminal

-- LazyDocker
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazydocker_toggle()
    lazydocker:toggle()
end

vim.api.nvim_set_keymap('n', 'td', '<cmd>lua _lazydocker_toggle()<CR>', { noremap = true, silent = true })

-- LazyGit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'tg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

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
