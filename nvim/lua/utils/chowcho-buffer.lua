local M = {}

local _chowcho_run = require('chowcho').run
local window_picker = require('window-picker') -- nvim-window-picker を読み込む

-- 現在のウィンドウのバッファ番号とローカルオプションを取得
M.get_bufnr_and_opt = function(winid)
  return vim.api.nvim_win_call(winid, function()
    local bufnr = vim.fn.bufnr('%')
    return bufnr, vim.opt_local
  end)
end

-- 指定ウィンドウにバッファとローカルオプションを設定
M.set_bufnr_and_opt = function(winid, bufnr, opt_local)
  return vim.api.nvim_win_call(winid, function()
    local old_bufnr = vim.fn.bufnr('%')
    vim.cmd("buffer " .. bufnr)
    vim.opt_local = opt_local
    return old_bufnr
  end)
end

-- バッファとローカルオプションを交換する関数
M.swap_buffers = function()
  local win_count = vim.fn.winnr('$')
  if win_count <= 2 then
    vim.cmd("wincmd x")
    return
  end

  -- nvim-window-picker を使用してウィンドウを選択
  local selected_winid = window_picker.pick_window()

  if not selected_winid then
    vim.notify("ウィンドウの選択がキャンセルされました。", vim.log.levels.INFO)
    return
  end

  local current_winid = vim.api.nvim_get_current_win()

  if selected_winid == current_winid then
    vim.notify("同じウィンドウが選択されました。スワップを中止します。", vim.log.levels.WARN)
    return
  end

  -- 現在のウィンドウと選択されたウィンドウのバッファ番号とオプションを取得
  local bufnr_current, opt_current = M.get_bufnr_and_opt(current_winid)
  local bufnr_selected, opt_selected = M.get_bufnr_and_opt(selected_winid)

  -- バッファとオプションをスワップ
  M.set_bufnr_and_opt(selected_winid, bufnr_current, opt_current)
  M.set_bufnr_and_opt(current_winid, bufnr_selected, opt_selected)

  vim.notify(string.format("ウィンドウ %d とウィンドウ %d をスワップしました。", current_winid, selected_winid), vim.log.levels.INFO)
end

return M
