local F = {}

-- Common keymaps
local kmap = require('utils.keymap')
local tuis = require('core.tuis')

local Mode = kmap.Mode

function F.global_navigation()
    kmap.normal('<C-h>', 'wincmd h')
    kmap.normal('<C-l>', 'wincmd l')
    kmap.normal('<C-j>', 'wincmd j')
    kmap.normal('<C-k>', 'wincmd k')

    kmap.terminal('<C-h>', '<C-\\><C-N>:wincmd h')
    kmap.terminal('<C-l>', '<C-\\><C-N>:wincmd l')
    kmap.terminal('<C-j>', '<C-\\><C-N>:wincmd j')
    kmap.terminal('<C-k>', '<C-\\><C-N>:wincmd k')
end

-- Tab navigation
function F.tab_navigation()
    kmap.normal('<C-n>', 'tabNext')
    kmap.normal('<C-c>', 'tabclose')
    kmap.normal('<C-t>', 'tabnew')
end

-- Telescope
function F.telescope()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-f>', builtin.find_files)
    vim.keymap.set('n', '<C-g>', builtin.live_grep)
end

function F.lsp_actions()
    -- LSP Actions (TODO: LSP設定側に隔離?)
    kmap.normal('<Space>', 'Lspsaga hover_doc')
    kmap.normal('gd', 'Lspsaga preview_definition')
    kmap.normal('gh', 'Lspsaga finder')
    kmap.normal('ga', 'Lspsaga code_action')
    kmap.normal('gs', 'Lspsaga show_line_diagnostics')
    kmap.normal('gr', 'Lspsaga rename')

    kmap.normal('gf', 'lua vim.lsp.buf.format()')
    kmap.normal('<S-CR>', 'lua vim.lsp.buf.definition()')
end

-- Hop
kmap.normal('<Leader>w', 'HopWord')

-- Shift + J/K (カーソル行の5行移動)
function F.shift_jk()
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-j>', '5j', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-k>', '5k', { _autoCmd = false })

    -- Ctrl + J/K (画面上のカーソル行を固定したままバッファ側をスクロールする動作)
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-j>', '5<C-E>5j', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-k>', '5<C-Y>5k', { _autoCmd = false })
end

-- Barbar
function F.buffer_nav()
    kmap.normal('<C-[>', 'BufferPrevious')
    kmap.normal('<C-]>', 'BufferNext')

    kmap.normal('<C-c>', 'BufferClose')
    kmap.normal('<C-r>', 'BufferRestore')
end

function F.common()
    -- Clipboard
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, 'cp', '"*p')
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, 'cy', '"*y')

    -- TUIs
    -- LazyGit
    kmap.normal('tg', tuis.lazygit_toggle())

    -- LazyDocker
    kmap.normal('td', tuis.lazydocker_toggle())
end

-- execute all functions
for _, fn in pairs(F) do
    fn()
end
