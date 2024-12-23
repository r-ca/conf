return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "V13Axel/neotest-pest",
    -- "marilari88/neotest-vitest"
    -- { dir = "/Users/rca/proj/neotest-vitest" }
    "r-ca/neotest-vitest",
    -- "olimorris/neotest-phpunit"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        -- require("neotest-phpunit"),
        require("neotest-pest")
      }
    })
  end
}
