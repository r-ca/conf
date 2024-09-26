-- Common keymaps
local kmap = require('utils.keymap')
local tuis = require('core.tuis')

local Mode = kmap.Mode

-- Global navigation
kmap.normal('<C-h>', 'wincmd h')
kmap.normal('<C-l>', 'wincmd l')
kmap.normal('<C-j>', 'wincmd j')
kmap.normal('<C-k>', 'wincmd k')

kmap.terminal('<C-h>', '<C-\\><C-N>:wincmd h')
kmap.terminal('<C-l>', '<C-\\><C-N>:wincmd l')
kmap.terminal('<C-j>', '<C-\\><C-N>:wincmd j')
kmap.terminal('<C-k>', '<C-\\><C-N>:wincmd k')

-- Tab navigation
kmap.normal('<C-n>', 'tabNext')
kmap.normal('<C-c>', 'tabclose')
kmap.normal('<C-t>', 'tabnew')

-- LSP Actions (TODO: LSP設定側に隔離?)
kmap.normal('<Space>', 'Lspsaga hover_doc')
kmap.normal('gd', 'Lspsaga preview_definition')
kmap.normal('gh', 'Lspsaga finder')
kmap.normal('ga', 'Lspsaga code_action')
kmap.normal('gs', 'Lspsaga show_line_diagnostics')

kmap.normal('gf', 'vim.lsp.buf.format()')
kmap.normal('<S-CR>', 'vim.lsp.buf.definition()')

-- Clipboard
kmap.set({Mode.NORMAL, Mode.VISUAL}, 'cp', '"*p')
kmap.set({Mode.NORMAL, Mode.VISUAL}, 'cy', '"*y')

-- TUIs
-- LazyGit
kmap.normal('tg', tuis.lazygit_toggle())

-- LazyDocker
kmap.normal('td', tuis.lazydocker_toggle())
