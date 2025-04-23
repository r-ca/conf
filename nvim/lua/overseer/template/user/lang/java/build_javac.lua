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
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "java" },
  },
}
