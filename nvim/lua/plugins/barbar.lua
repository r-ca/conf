return {
    'romgrk/barbar.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim'
    },
    opts = {
        animation = true,
		gitsigns = {
			added = {
				enabled = true,
				icon = '+'
			},
			changed = {
				enabled = true,
				icon = '~'
			},
			deleted = {
				enabled = true,
				icon = '-'
			},
		},
		sidebar_filetypes = {
			NvimTree = true,
		},
    },
    config = function()
        -- Change buffer
        vim.api.nvim_set_keymap('n', '<C-]>', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-[>', ':BufferPrevious<CR>', { noremap = true, silent = true })
        -- Reorder buffer
        vim.api.nvim_set_keymap('n', '<C-S-]>', ':BufferMoveNext<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-S-[>', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
        -- Close buffer
        vim.api.nvim_set_keymap('n', '<C-i>', ':BufferClose<CR>', { noremap = true, silent = true })
        -- Restore buffer
        vim.api.nvim_set_keymap('n', '<C-S-i>', ':BufferRestore<CR>', { noremap = true, silent = true })
    end
}
