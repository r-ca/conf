-- ~/.config/nvim/lua/overseer/template/user/c_compile_and_run.lua
return {
  name = "Compile & Run C",
  builder = function()
    local filepath = vim.fn.expand("%:p")   -- フルパス
    local basename = vim.fn.expand("%:t:r") -- 拡張子なしのファイル名
    local cmd = string.format(
      "gcc %s -o %s.out && ./%s.out",
      vim.fn.shellescape(filepath),
      vim.fn.shellescape(basename),
      vim.fn.shellescape(basename)
    )
    return {
      cmd = { "bash", "-c", cmd },
      components = {
        { "open_output", focus = true, direction = "horizontal" },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
