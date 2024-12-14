local M = {}

local chowcho_run = require('chowcho').run

-- 現在のバッファ番号とオプションを取得する関数
local function get_bufnr_and_opt(winid)
  return vim.api.nvim_win_call(winid, function()
    local bufnr = vim.fn.bufnr('%')
    local opt_local = vim.opt_local:get()
    return bufnr, opt_local
  end)
end

-- バッファとオプションを設定する関数
local function set_bufnr_and_opt(winid, bufnr, opt_local)
  return vim.api.nvim_win_call(winid, function()
    local old_bufnr = vim.fn.bufnr('%')
    vim.cmd("buffer " .. bufnr)
    for key, value in pairs(opt_local) do
      vim.opt_local[key] = value
    end
    return old_bufnr
  end)
end

-- バッファを入れ替えるメイン関数
function M.swap_buffers()
  chowcho_run(function(n)
    if vim.fn.winnr('$') <= 2 then
      vim.cmd("wincmd x")
      return
    end

    -- 現在のウィンドウ（0）と対象ウィンドウ（n）のバッファとオプションを取得
    local bufnr0, opt_local0 = get_bufnr_and_opt(0)
    local bufnrn, opt_localn = get_bufnr_and_opt(n)

    -- バッファとオプションを入れ替える
    set_bufnr_and_opt(n, bufnr0, opt_local0)
    set_bufnr_and_opt(0, bufnrn, opt_localn)
  end)
end

return M
