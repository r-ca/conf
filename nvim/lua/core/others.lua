-- Others
vim.api.nvim_create_user_command('PackageInfo',
  function(opts)
    require('package-info').show({ force = true })
  end, {
    nargs = 0
  }
)

-- Restore cursor position
local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    callback = function()
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
      if { row, col } ~= { 0, 0 } then
        vim.api.nvim_win_set_cursor(0, { row, 0 })
      end
    end,
    group = group
  }
)

-- Close all floating windows
vim.api.nvim_create_user_command('ForceCloseFloat',
  function(opts)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then        -- is_floating_window?
        vim.api.nvim_win_close(win, false) -- do not force
      end
    end
  end, {
    nargs = 0
  }
)

vim.api.nvim_create_user_command('DismissNotify',
  function(opts)
    require('noice').cmd('dismiss')
  end, {
    nargs = 0
  }
)

-- local window_picker = require('window-picker')

function SwapWindowsById(win1, win2)
  -- 現在のバッファIDを取得
  local buf1 = vim.api.nvim_win_get_buf(win1)
  local buf2 = vim.api.nvim_win_get_buf(win2)

  -- ウィンドウのバッファをスワップ
  vim.api.nvim_win_set_buf(win1, buf2)
  vim.api.nvim_win_set_buf(win2, buf1)
end

-- function SwapWithPickedWindow()
--   local picked_window_id = window_picker.pick_window()
--   if picked_window_id and vim.api.nvim_win_is_valid(picked_window_id) then
--     SwapWindowsById(vim.api.nvim_get_current_win(), picked_window_id)
--   else
--     vim.notify("Invalid window selected", vim.log.levels.ERROR)
--   end
-- end

-- UserCommand: ウィンドウピッカーで選択したウィンドウをスワップ
vim.api.nvim_create_user_command('SwapWindow', function()
  SwapWithPickedWindow()
end, { nargs = 0 })


local neotest = require("neotest")

vim.api.nvim_create_user_command("NeotestSummary", function()
  neotest.summary.toggle()
end, {})

vim.api.nvim_create_user_command("NeotestFile", function()
  neotest.run.run(vim.fn.expand("%"))
end, {})

vim.api.nvim_create_user_command("Neotest", function()
  neotest.run.run(vim.fn.getcwd())
end, {})

vim.api.nvim_create_user_command("NeotestNearest", function()
  neotest.run.run()
end, {})

vim.api.nvim_create_user_command("NeotestDebug", function()
  neotest.run.run({ strategy = "dap" })
end, {})

vim.api.nvim_create_user_command("NeotestAttach", function()
  neotest.run.attach()
end, {})
