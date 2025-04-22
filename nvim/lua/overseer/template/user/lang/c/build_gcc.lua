return {
  name = "Compile & Run C",
  builder = function(_)
    local filepath = vim.fn.expand("%:p")
    local basename = vim.fn.expand("%:t:r")
    return {
      cmd        = "bash",
      args       = {
        "-c",
        string.format(
          "gcc %s -o %s && ./%s",
          vim.fn.shellescape(filepath),
          vim.fn.shellescape(basename),
          vim.fn.shellescape(basename)
        )
      },
      components = { "on_output_quickfix" },
    }
  end,
}
