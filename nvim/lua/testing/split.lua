-- 選択されたウィンドウIDを記録するテーブル
local selected_window_ids = {}

-- ウィンドウを選択し、Winbarに表示し、ウィンドウIDを記録する関数
local function select_window()
  local win_id = vim.api.nvim_get_current_win()  -- 現在のウィンドウIDを取得
  vim.api.nvim_win_set_option(win_id, 'winbar', '選択中')  -- Winbarに選択中と表示
  table.insert(selected_window_ids, win_id)  -- ウィンドウIDをテーブルに記録
  print("ウィンドウID " .. win_id .. " が選択されました")
end

-- 選択されたウィンドウIDで縦分割を行う関数
local function arrange_windows_vertically()
  if #selected_window_ids == 0 then
    print("選択されたウィンドウがありません")
    return
  end

  -- 最初のウィンドウに移動して分割を開始
  vim.api.nvim_set_current_win(selected_window_ids[1])

  -- 残りのウィンドウを縦分割して配置
  for i = 2, #selected_window_ids do
    vim.cmd('split')  -- 縦分割
    vim.api.nvim_set_current_win(selected_window_ids[i])  -- 次のウィンドウに移動
  end

  -- 処理後にウィンドウIDをリセット
  selected_window_ids = {}
  print("ウィンドウを縦分割で並べました")
end

-- コマンドの作成

-- ウィンドウ選択のためのコマンド (例: :SelectWindow)
vim.api.nvim_create_user_command('SelectWindow', function()
  select_window()
end, {})

-- 縦分割で並べるためのコマンド (例: :ArrangeWindows)
vim.api.nvim_create_user_command('ArrangeWindows', function()
  arrange_windows_vertically()
end, {})

