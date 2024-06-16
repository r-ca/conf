return {
    'yioneko/nvim-yati',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            highlight = {
            enable = true,
            },
            yati = {
                suppress_conflict_warning = true
            },
        })
    end,
}
