local api = vim.api
local M = {
  float_wins = {},  -- bufnr → winid のマップ
}

--- 右下にフロート化 or トグルで閉じる
function M.float_buffer()
  local bufnr = api.nvim_get_current_buf()

  -- すでにフロート表示中なら閉じる
  local winid = M.float_wins[bufnr]
  if winid and api.nvim_win_is_valid(winid) then
    api.nvim_win_close(winid, true)
    M.float_wins[bufnr] = nil
    return
  end

  -- フロートのサイズ・位置を計算
  local height = math.floor(vim.o.lines * 0.4)
  local width  = math.floor(vim.o.columns * 0.5)
  local row    = vim.o.lines  - height - 1
  local col    = vim.o.columns - width  - 1

  -- フロートウィンドウを開く
  winid = api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width    = width,
    height   = height,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "single",
  })
  api.nvim_set_current_win(winid)

  -- ターミナル以外ならノーマルモード、ターミナルなら挿入モード
  if vim.bo[bufnr].buftype == "terminal" then
    vim.cmd("startinsert")
  end

  M.float_wins[bufnr] = winid
end

--- 新しいタブを開いて全画面表示
function M.tab_buffer()
  local bufnr = api.nvim_get_current_buf()
  vim.cmd("tabnew")           -- 新規タブ（空白バッファ）
  api.nvim_set_current_buf(bufnr)
  -- ターミナルなら挿入モードに入る
  if vim.bo[bufnr].buftype == "terminal" then
    vim.cmd("startinsert")
  end
end

-- コマンドを登録
vim.api.nvim_create_user_command("FloatBuffer", M.float_buffer, { range = true })
vim.api.nvim_create_user_command("TabBuffer", M.tab_buffer, { range = true })
