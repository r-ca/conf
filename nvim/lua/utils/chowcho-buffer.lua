local M = {}

local _chowcho_run = require('chowcho').run

-- 現在のウィンドウのバッファ番号とローカルオプションを取得
M.get_bufnr_and_opt = function(winid)
  return vim.api.nvim_win_call(winid, function()
    local bufnr = vim.fn.bufnr('%')
    return bufnr, vim.opt_local
  end)
end

-- 指定ウィンドウにバッファとローカルオプションを設定
M.set_bufnr_and_opt = function(winid, bufnr, opt_local)
  return vim.api.nvim_win_call(winid, function()
    local old_bufnr = vim.fn.bufnr('%')
    vim.cmd("buffer " .. bufnr)
    vim.opt_local = opt_local
    return old_bufnr
  end)
end

-- バッファとローカルオプションを交換する
M.swap_buffers = function()
  _chowcho_run(function(n)
    if vim.fn.winnr('$') <= 2 then
      vim.cmd("wincmd x")
      return
    end

    local bufnr0, opt_local0 = M.get_bufnr_and_opt(0)
    local bufnrn, opt_localn = M.get_bufnr_and_opt(n)

    M.set_bufnr_and_opt(n, bufnr0, opt_local0)
    M.set_bufnr_and_opt(0, bufnrn, opt_localn)
  end)
end

return M
