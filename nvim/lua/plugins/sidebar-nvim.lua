return {
  'sidebar-nvim/sidebar.nvim',
  config = function()
    require('sidebar-nvim').setup({
      disable_default_keybindings = 1,
    })
    -- toggle
    vim.api.nvim_set_keymap('n', '<F2>', ':lua require("sidebar-nvim").toggle()<CR>', { noremap = true, silent = true })
  end
}
