-- Float Window Move/Resize Utility (矢印キーで移動、hjklでリサイズ)
local function float_win_resizer(winid)
  if not vim.api.nvim_win_is_valid(winid) then return end

  -- 現在の設定を取得（row/col は数値）
  local cfg = vim.api.nvim_win_get_config(winid)

  -- 設定を反映するヘルパー
  local function apply()  
    vim.api.nvim_win_set_config(winid, cfg)
  end

  -- キーマッピング用ヘルパー
  local function map(key, fn)
    vim.keymap.set('n', key, function()
      fn()
      apply()
    end, { buffer = 0, silent = true })
  end

  -- ── 移動 ──
  map('<Left>',  function() cfg.col = cfg.col - 1 end)
  map('<Right>', function() cfg.col = cfg.col + 1 end)
  map('<Up>',    function() cfg.row = cfg.row - 1 end)
  map('<Down>',  function() cfg.row = cfg.row + 1 end)

  -- ── リサイズ ──
  -- 左方向
  map('h', function()  -- 縮小：左端を内側に
    cfg.col   = cfg.col + 1
    cfg.width = math.max(1, cfg.width - 1)
  end)
  map('H', function()  -- 拡大：左側に広げる
    cfg.col   = cfg.col - 1
    cfg.width = cfg.width + 1
  end)
  -- 右方向
  map('l', function()  -- 縮小：右端を内側に
    cfg.width = math.max(1, cfg.width - 1)
  end)
  map('L', function()  -- 拡大：右側に広げる
    cfg.width = cfg.width + 1
  end)
  -- 上方向
  map('k', function()  -- 縮小：上端を下に
    cfg.row    = cfg.row + 1
    cfg.height = math.max(1, cfg.height - 1)
  end)
  map('K', function()  -- 拡大：上側に広げる
    cfg.row    = cfg.row - 1
    cfg.height = cfg.height + 1
  end)
  -- 下方向
  map('j', function()  -- 縮小：下端を上に
    cfg.height = math.max(1, cfg.height - 1)
  end)
  map('J', function()  -- 拡大：下側に広げる
    cfg.height = cfg.height + 1
  end)

  -- ESC でモード終了
  vim.keymap.set('n', '<Esc>', function()
    vim.cmd('echo "Float Move/Resize モード終了"')
    for _, key in ipairs({ '<Left>','<Right>','<Up>','<Down>',
                          'h','H','j','J','k','K','l','L','<Esc>' }) do
      vim.keymap.del('n', key, { buffer = 0 })
    end
  end, { buffer = 0, silent = true })

  vim.cmd('echo "Floatモード: ←↑→↓で移動, hjklで縮小, Shift+hjklで拡大, ESCで終了"')
end

-- <leader>fm で起動
vim.keymap.set('n', '<leader>fm', function()
  float_win_resizer(vim.api.nvim_get_current_win())
end, { desc = "Float Move/Resize" })
