return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  opts = {},
  config = function()
    require('render-markdown').setup({
      overrides = {
        buflisted = { [false] = { enabled = false } },
      }
    })
  end
}
