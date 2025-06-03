return {
  name = "Run on Python3",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "python3", file },
      components = {
        { "open_output", focus = true, direction = "horizontal" },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
