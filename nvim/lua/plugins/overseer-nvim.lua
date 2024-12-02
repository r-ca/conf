return {
  'stevearc/overseer.nvim',
  dependencies = { 'stevearc/dressing.nvim' },
  opts = {},
  config = function()
    require('overseer').setup()
  end,
}
