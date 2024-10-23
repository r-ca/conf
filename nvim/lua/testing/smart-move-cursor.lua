-- ノードのレンジを取得してカーソルを移動するヘルパー関数
local function move_cursor_to_position(row, col)
  vim.api.nvim_win_set_cursor(0, {row + 1, col})
end

-- 行末がコメントノードかを確認し、コメントならその直前のノードにカーソルを移動し、
-- すでにコード部の末端にいる場合はコメントを含めた行末に移動する関数
local function move_cursor_to_node_or_end_of_line()
  local parser = vim.treesitter.get_parser(0)
  local tree = parser:parse()[1]
  local root = tree:root()
  local current_line = vim.fn.line('.') - 1 -- 現在の行番号を取得（0-based index）
  local last_col = vim.fn.col('$') - 1 -- 現在の行の最後の列を取得（0-based index）
  local last_non_comment_node = nil
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_row = current_cursor[1] - 1
  local cursor_col = current_cursor[2]

  -- ノードを再帰的に探索して行末にコメントがあるか確認
  local function check_node_at_line_end(node)
    local start_row, _, end_row, end_col = node:range()

    -- 現在の行にあるノードのみを対象にする
    if start_row <= current_line and current_line <= end_row then
      -- 行末にあるノードをチェック
      if end_row == current_line and end_col == last_col then
        if node:type() == "comment" then
          if last_non_comment_node then
            local _, _, ln_end_row, ln_end_col = last_non_comment_node:range()

            -- すでにコード部の末端にカーソルがあるかを確認
            if cursor_row == ln_end_row and cursor_col == ln_end_col then
              -- カーソルがコード部末端にある場合はコメントも含めた行末に移動
              move_cursor_to_position(end_row, end_col)
              print("コメントを含めた行末に移動しました")
            else
              -- まだコード部末端にいない場合はコード末端に移動
              move_cursor_to_position(ln_end_row, ln_end_col)
              print("コメント手前に移動しました")
            end
          end
          return true
        end
      end

      -- コメント以外のノードを直前のノードとして記録
      if node:type() ~= "comment" then
        last_non_comment_node = node
      end

      -- 子ノードを再帰的に探索
      for i = 0, node:child_count() - 1 do
        local child = node:child(i)
        if child then
          if check_node_at_line_end(child) then
            return true -- コメントノードが見つかったら早期終了
          end
        end
      end
    end
    return false
  end

  -- ルートノードからチェックを開始
  if not check_node_at_line_end(root) then
    -- コメントノードがない場合は普通に行末に移動
    move_cursor_to_position(current_line, last_col)
    print("行末に移動しました")
  end
end

-- ユーザーコマンドを登録
vim.api.nvim_create_user_command('SmartMoveCursorEoL', function()
  move_cursor_to_node_or_end_of_line()
end, {})
