return {
    'sidebar-nvim/sidebar.nvim',
    config = function()
        require('sidebar-nvim').setup({
            disable_default_keybindings = 1,
        })
        -- toggle
        
    end
}
