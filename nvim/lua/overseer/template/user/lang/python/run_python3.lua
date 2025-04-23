return {
  name = "Run on Python3",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "python3", file },
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
