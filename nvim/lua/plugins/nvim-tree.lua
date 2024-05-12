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
                    local api = require('nvim-tree.api')
                    api.config.mapping.default_on_attach(bufnr) -- TODO: やめる

                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>', api.node.open.edit, { noremap = false, silent = true })
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Tab>', api.node.open.tab, { noremap = false, silent = true })
                end
            })
            -- Toggle NvimTree
            vim.api.nvim_set_keymap('n', 'tf', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
    }
}
