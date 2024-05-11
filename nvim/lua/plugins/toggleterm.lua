return {
    {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup({
                size = 20,
                direction = 'float',
                start_in_insert = true,
                float_opts = {
                    border = 'curved',
                }
            })
            vim.api.nvim_set_keymap('n', '<F1>', '<cmd>lua require("toggleterm").toggle()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('t', '<F1>', '<cmd>lua require("toggleterm").toggle()<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('i', '<F1>', '<cmd>lua require("toggleterm").toggle()<CR>', { noremap = true, silent = true })
        end
    }
}
