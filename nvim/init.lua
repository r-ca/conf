
-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Workaround
vim.opt.termguicolors = true

-- Load plugins dir
require('lazy').setup({
    spec = {
        { import = "plugins" },
        { import = "lsp" },
        { import = "lsp.lang" },
        { import = "colors" }
    }
})

-- Load core
require('core.options')
require('core.others')
require('core.keymaps')

local Job = require('plenary.job')

local function send_visual_selection()
  -- 選択範囲の開始と終了行、列を取得
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  -- 選択範囲のテキストを取得
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

  -- Ensure we have selected content
  if #lines == 0 or (start_row == end_row and start_col == end_col) then
    print("No selection")
    return
  end

  -- Adjust for the first and last line's column selection
  lines[1] = string.sub(lines[1], start_col + 1)
  if #lines > 1 then
    lines[#lines] = string.sub(lines[#lines], 1, end_col + 1)
  end

  -- 選択されたテキストを結合
  local selection = table.concat(lines, "\n")

  -- HTTP POST request setup using plenary Job
  Job:new({
    command = 'curl',
    args = {
      '-X', 'POST',
      '-H', 'Content-Type: text/plain; charset=utf-8',
      '-d', selection,
      'http://172.16.10.148:8080/'
    },
    on_exit = function(j, return_val)
      if return_val == 0 then
        print("Selection sent to server successfully.")
      else
        print("Failed to send selection. Error code: " .. return_val)
      end
    end,
  }):start()
end


-- コマンドを作成
vim.api.nvim_create_user_command("SendSelection", send_visual_selection, { range = true })

