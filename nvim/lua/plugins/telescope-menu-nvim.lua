return {
  'octarect/telescope-menu.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension('menu')
  end
}
