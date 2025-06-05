return {
  'mvllow/modes.nvim',
  config = function()
    require('modes').setup({
      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore = { 'NvimTree', 'TelescopePrompt' }
    })
  end
}
