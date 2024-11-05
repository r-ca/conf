return {
    'Shatur/neovim-ayu',
    config = function()
        require('ayu').setup({
            mirage = true,
        })

        -- add command
        vim.api.nvim_create_user_command('AyuDark', 'colorscheme ayu-mirage', {})
        vim.api.nvim_create_user_command('AyuLight', 'colorscheme ayu-light', {})
    end,
}
