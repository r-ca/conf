return {
  name = "Compile & Run Java",
  builder = function()
    local file = vim.fn.expand("%:p")
    local classname = vim.fn.expand("%:t:r")
    local cmd = string.format(
      "javac %s && java %s",
      vim.fn.shellescape(file),
      vim.fn.shellescape(classname)
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
    filetype = { "java" },
  },
}
