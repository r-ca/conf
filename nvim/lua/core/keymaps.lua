local F = {}

-- Common keymaps
local kmap = require('utils.keymap')
local tuis = require('core.tuis')
local luasnip = require('luasnip')
local float_util = require('utils.float-util')

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

function F.common_navigation()
  -- kmap.set({ Mode.NORMAL, Mode.SELECT }, '<C-e>', function()
  --   chowcho_buffer.swap_buffers()
  -- end)

  -- Split (C-s/C-S-s)
  kmap.normal('<C-s>', 'split')
  kmap.normal('<C-S-s>', 'vsplit')
end

function F.windows()
  -- kmap.normal('<Leader>mm', 'WindowsMaximize')
  kmap.normal('<C-m>', 'WindowsMaximize')
  kmap.normal('<Leader>mvm', 'WindowsMaximizeVertically')
  kmap.normal('<Leader>mh', 'WindowsMaximizeHorizontally')
  kmap.normal('<Leader>me', 'WindowsEqualize')
  kmap.normal('<Leader>mt', 'WindowsToggleAutowidth')
end

function F.luasnip()
  -- TODO: LuaSnipが動いてないときは他のことに使えるようにしたい
  kmap.set({ Mode.INSERT, Mode.SELECT }, '<C-l>', function ()
    luasnip.jump(1)
  end, { _autoCmd = false })
  kmap.set({ Mode.INSERT, Mode.SELECT }, '<C-h>', function ()
    luasnip.jump(-1)
  end, { _autoCmd = false })

  kmap.set({ Mode.INSERT, Mode.SELECT }, '<C-n>', function ()
    luasnip.change_choice(1)
  end, { _autoCmd = false })
  kmap.set({ Mode.INSERT, Mode.SELECT }, '<C-p>', function ()
    luasnip.change_choice(-1)
  end, { _autoCmd = false })

  kmap.set({ Mode.INSERT, Mode.SELECT }, '<C-e>', function ()
    luasnip.expand()
  end, { _autoCmd = false })
end

-- Tab navigation
-- function F.tab_navigation()
--   kmap.normal('<C-n>', 'tabNext')
--   kmap.normal('<C-c>', 'tabclose')
--   kmap.normal('<C-t>', 'tabnew')
-- end

-- Telescope
function F.telescope()
  kmap.normal('<Leader>g', 'Telescope egrepify')
  kmap.normal('<Leader>f', 'Telescope find_files')
  kmap.normal('<Leader>p', 'Telescope projects')
  kmap.normal('tt', 'Telescope commands')
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

  -- Ctrl + Shift + H/L (行の先頭/いい感じの末尾に移動)
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

  kmap.normal('<C-e>', 'SwapWindow')

  -- JumpBack/Forward
  kmap.set({ Mode.NORMAL, Mode.VISUAL, Mode.INSERT }, '<C-b>', '<C-o>', { _autoCmd = false })
  kmap.set({ Mode.NORMAL, Mode.VISUAL, Mode.INSERT }, '<C-n>', '<C-i>', { _autoCmd = false })

  -- Escape→Insert next line
  kmap.insert('<C-o>', '<Esc>o', { _autoCmd = false })

  -- Move cursor in insert mode
  kmap.insert('<C-h>', '<Left>', { _autoCmd = false })
  kmap.insert('<C-l>', '<Right>', { _autoCmd = false })
  kmap.insert('<C-j>', '<Down>', { _autoCmd = false })
  kmap.insert('<C-k>', '<Up>', { _autoCmd = false })
end

function F.overseer()
  kmap.normal('<Leader>r', 'OverseerRun')
end

function F.float()
  kmap.set({ Mode.NORMAL, Mode.TERMINAL }, '<C-t>', function()
    float_util.toggle_view()
  end, { _autoCmd = false })
end

-- execute all functions
for _, fn in pairs(F) do
  fn()
end
