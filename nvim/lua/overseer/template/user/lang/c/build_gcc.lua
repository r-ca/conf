-- ~/.config/nvim/lua/overseer/template/user/c_compile_and_run.lua
return {
  name = "Compile & Run C",
  builder = function()
    local filepath = vim.fn.expand("%:p")   -- フルパス
    local basename = vim.fn.expand("%:t:r") -- 拡張子なしのファイル名
    local cmd = string.format(
      "gcc %s -o %s && ./%s",
      vim.fn.shellescape(filepath),
      vim.fn.shellescape(basename),
      vim.fn.shellescape(basename)
    )
    return {
      cmd = { "bash", "-c", cmd },
      components = {
        -- { "on_output_quickfix", open = true },
        { "open_output", focus = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
