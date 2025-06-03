return {
  'stevearc/overseer.nvim',
  dependencies = { 'stevearc/dressing.nvim' },
  opts = {},
  config = function()
    require("overseer").setup({
      strategy = "toggleterm",
      task_list = {
        bindings = {
          ["<C-h>"] = 'wincmd h',
          ["<C-l>"] = 'wincmd l',
          ["<C-j>"] = 'wincmd j',
          ["<C-k>"] = 'wincmd k',
        }
      }
    })
  end,
}
