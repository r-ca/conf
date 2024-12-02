return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<F5>",
      "<cmd>Trouble diagnostics toggle<cr>",
    },
    {
      "<F6>",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
    },
  },
}
