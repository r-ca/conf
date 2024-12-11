return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "marilari88/neotest-vitest"
    { dir = "/Users/rca/proj/neotest-vitest" }
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest")
      }
    })
  end
}
