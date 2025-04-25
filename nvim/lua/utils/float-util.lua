local api = vim.api
local M = {
  float_win = {}, -- bufnr -> float winid
  prev_win  = {}, -- bufnr -> prev winid
}

--- 任意バッファをフロート表示
--- @param opts table? { width, height, row, col, border }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.float_buffer(opts, bufnr)
  bufnr              = bufnr or api.nvim_get_current_buf()
  opts               = opts or {}
  local width        = opts.width or math.floor(vim.o.columns * 0.5)
  local height       = opts.height or math.floor(vim.o.lines * 0.4)
  local row          = opts.row or (vim.o.lines - height - 2)
  local col          = opts.col or math.floor((vim.o.columns - width) / 2)

  -- フロート生成（フォーカスは移動しない）
  local winid        = api.nvim_open_win(bufnr, false, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = opts.border or "single",
  })

  M.float_win[bufnr] = winid
end

--- 任意バッファを全画面表示（現在のウィンドウでバッファを切り替え）
--- @param opts table? { startinsert = bool }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.open_fullscreen(opts, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  opts = opts or {}
  -- 現在のウィンドウでバッファを表示
  api.nvim_set_current_buf(bufnr)
  if opts.startinsert and vim.bo[bufnr].buftype == "terminal" then
    vim.cmd("startinsert")
  end
end

--- 任意バッファをフロート⇔全画面でトグル
--- @param opts table? フロート用に { width, height, row, col, border, startinsert }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.toggle_view(opts, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  opts = opts or {}

  -- すでにフロートが開いていれば閉じて全画面表示
  local float_win = M.float_win[bufnr]
  if float_win and api.nvim_win_is_valid(float_win) then
    api.nvim_win_close(float_win, true)
    M.float_win[bufnr] = nil
    -- 全画面表示に切り替え
    M.open_fullscreen(opts, bufnr)
  else
    -- フロートがなければ、開く前のウィンドウを記録してフロート化
    local cur_win = api.nvim_get_current_win()
    M.prev_win[bufnr] = cur_win
    M.float_buffer(opts, bufnr)
    -- フォーカスを元のウィンドウに戻す
    if api.nvim_win_is_valid(cur_win) then
      api.nvim_set_current_win(cur_win)
    end
  end
end

return M
