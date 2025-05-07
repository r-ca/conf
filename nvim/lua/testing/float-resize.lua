local M = {}

M.opts = {
  toggle = "<leader>fm",
  move = { left = "<Left>", right = "<Right>", up = "<Up>", down = "<Down>" },
  resize = {
    shrink = { left = "h", right = "l", up = "k", down = "j" },
    expand = { left = "H", right = "L", up = "K", down = "J" },
  },
  quit = "<Esc>",
}

function M.attach(winid, opts)
  if not vim.api.nvim_win_is_valid(winid) then return end
  opts = vim.tbl_deep_extend("force", M.opts, opts or {})

  local cfg = vim.api.nvim_win_get_config(winid)
  local map_buf = function(key, fn)
    vim.keymap.set('n', key, function()
      fn()
      vim.api.nvim_win_set_config(winid, cfg)
    end, { buffer = 0, silent = true })
  end

  map_buf(opts.move.left, function() cfg.col = cfg.col - 1 end)
  map_buf(opts.move.right, function() cfg.col = cfg.col + 1 end)
  map_buf(opts.move.up, function() cfg.row = cfg.row - 1 end)
  map_buf(opts.move.down, function() cfg.row = cfg.row + 1 end)

  map_buf(opts.resize.shrink.left, function()
    cfg.col   = cfg.col + 1
    cfg.width = math.max(1, cfg.width - 1)
  end)
  map_buf(opts.resize.shrink.right, function()
    cfg.width = math.max(1, cfg.width - 1)
  end)
  map_buf(opts.resize.shrink.up, function()
    cfg.row    = cfg.row + 1
    cfg.height = math.max(1, cfg.height - 1)
  end)
  map_buf(opts.resize.shrink.down, function()
    cfg.height = math.max(1, cfg.height - 1)
  end)

  map_buf(opts.resize.expand.left, function()
    cfg.col   = cfg.col - 1
    cfg.width = cfg.width + 1
  end)
  map_buf(opts.resize.expand.right, function()
    cfg.width = cfg.width + 1
  end)
  map_buf(opts.resize.expand.up, function()
    cfg.row    = cfg.row - 1
    cfg.height = cfg.height + 1
  end)
  map_buf(opts.resize.expand.down, function()
    cfg.height = cfg.height + 1
  end)

  vim.keymap.set('n', opts.quit, function()
    vim.cmd('echo "Exit."')
    local keys = {
      opts.move.left, opts.move.right, opts.move.up, opts.move.down,
      opts.resize.shrink.left, opts.resize.shrink.right,
      opts.resize.shrink.up, opts.resize.shrink.down,
      opts.resize.expand.left, opts.resize.expand.right,
      opts.resize.expand.up, opts.resize.expand.down,
      opts.quit,
    }
    for _, k in ipairs(keys) do
      pcall(vim.keymap.del, 'n', k, { buffer = 0 })
    end
  end, { buffer = 0, silent = true })

  vim.cmd('echo "Start"')
end

function M.resize_current(opts)
  local winid = vim.api.nvim_get_current_win()
  M.attach(winid, opts)
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  vim.keymap.set('n', M.opts.toggle, function()
    M.resize_current(M.opts)
  end, { desc = 'Float Move/Resize', silent = true })
end

return M
