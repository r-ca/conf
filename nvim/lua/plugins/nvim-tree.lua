return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('nvim-tree').setup({
                update_focused_file = {
                    enable = true,
                },
                view = {
                    width = 30,
                },
                on_attach = function(bufnr)
                    local api = require 'nvim-tree.api'
                    api.config.mappings.default_on_attach(bufnr) -- TODO: やめる

                    vim.keymap.set('n', '<Space>', api.node.open.edit, { buffer = bufnr })
                    vim.keymap.set('n', '<Tab>', api.node.open.tab, { buffer = bufnr })
                end
            })
            -- Toggle NvimTree
            vim.api.nvim_set_keymap('n', 'tf', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
    }
}
