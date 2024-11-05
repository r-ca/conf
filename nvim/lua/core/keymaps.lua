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
    kmap.normal('tf', builtin.find_files)
    kmap.normal('tg', builtin.live_grep)
end

-- LSP Actions
function F.lsp_actions()
    kmap.normal('<Space>', 'Lspsaga hover_doc')
    kmap.normal('gd', 'Lspsaga preview_definition')
    kmap.normal('gh', 'Lspsaga finder')
    kmap.normal('ga', 'Lspsaga code_action')
    kmap.normal('gs', 'Lspsaga show_line_diagnostics')
    kmap.normal('gr', 'Lspsaga rename')

    kmap.normal('gf', 'lua vim.lsp.buf.format()')
    kmap.normal('<S-CR>', 'lua vim.lsp.buf.definition()')
end

function F.shift_hjkl()
    -- Shift + J/K (カーソル行の5行移動)
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-j>', '5j', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-k>', '5k', { _autoCmd = false })

    -- Ctrl + Shift + J/K (画面上のカーソル行を固定したままバッファ側をスクロールする動作)
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-S-j>', '5<C-E>5j', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-S-k>', '5<C-Y>5k', { _autoCmd = false })

    -- Shift + H/L (単語でジャンプ, w/bの動作)
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-h>', 'b', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<S-l>', 'w', { _autoCmd = false })

    -- Ctrl + Shift + H/L (バッファの先頭/末尾に移動)
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-S-h>', '^', { _autoCmd = false })
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, '<C-S-l>', 'SmartMoveCursorEoL')
end

-- Barbar
function F.buffer_nav()
    kmap.normal('<C-[>', 'BufferPrevious')
    kmap.normal('<C-]>', 'BufferNext')

    kmap.normal('<C-c>', 'BufferClose')
    kmap.normal('<C-r>', 'BufferRestore')
end

function F.common()
    kmap.normal('<C-f>', 'Neotree toggle')

    -- Clipboard
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, 'cp', '"*p')
    kmap.set({ Mode.NORMAL, Mode.VISUAL }, 'cy', '"*y')

    -- TUIs
    -- LazyGit
    kmap.normal('<C-g>', tuis.lazygit_toggle())

    -- LazyDocker
    kmap.normal('<F2>', tuis.lazydocker_toggle())
    -- Hop
    kmap.normal('<Leader>w', 'HopWord')

    -- 空行挿入
    kmap.normal('<Leader>o', 'call append(line("."), "")')
    kmap.normal('<Leader>O', 'call append(line(".")-1, "")')
end

-- execute all functions
for _, fn in pairs(F) do
    fn()
end
