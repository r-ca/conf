return {
  "google/executor.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("executor").setup({})
    -- your setup here
  end,
}
