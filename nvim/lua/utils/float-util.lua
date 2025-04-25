local api = vim.api
local M = {}

--- 任意バッファをフロート表示
--- @param opts table? { width, height, row, col, border }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.float_buffer(opts, bufnr)
  bufnr        = bufnr or api.nvim_get_current_buf()
  opts         = opts or {}
  local width  = opts.width or math.floor(vim.o.columns * 0.5)
  local height = opts.height or math.floor(vim.o.lines * 0.4)
  local row    = opts.row or (vim.o.lines - height - 2)
  local col    = opts.col or math.floor((vim.o.columns - width) / 2)

  api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = opts.border or "single",
  })
end

--- 任意バッファを全画面タブ表示
--- @param opts table? { startinsert = bool }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.open_fullscreen(opts, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  opts = opts or {}
  -- 他ウィンドウを閉じて現在のウィンドウを唯一のウィンドウにする
  vim.cmd("only")
  -- バッファ切り替え
  api.nvim_set_current_buf(bufnr)
  -- ターミナルなら挿入モード
  if opts.startinsert and vim.bo[bufnr].buftype == "terminal" then
    vim.cmd("startinsert")
  end
end


--- 任意バッファをフロート⇔全画面でトグル
--- @param opts table? フロート用に同様の { width, height, row, col, border, startinsert }
--- @param bufnr number? 対象バッファ番号（省略時は現在のバッファ）
function M.toggle_view(opts, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  opts = opts or {}
  -- 現在のウィンドウ設定を取得
  local win = api.nvim_get_current_win()
  local cfg = api.nvim_win_get_config(win)
  -- relative が "editor" ならフロート
  if cfg.relative == "editor" then
    -- フロートウィンドウを閉じ
    api.nvim_win_close(win, true)
    -- 全画面表示へ切り替え
    M.open_fullscreen(opts, bufnr)
  else
    -- 通常ウィンドウ → フロート化
    M.float_buffer(opts, bufnr)
  end
end

return M
