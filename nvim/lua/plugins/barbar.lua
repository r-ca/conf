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
        vim.api.nvim_set_keymap('n', '<C-l>', ':BufferNext<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-h>', ':BufferPrevious<CR>', { noremap = true, silent = true })
        -- Reorder buffer
        vim.api.nvim_set_keymap('n', '<C-S-L>', ':BufferMoveNext<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-S-H>', ':BufferMovePrevious<CR>', { noremap = true, silent = true })
        -- Close buffer
        vim.api.nvim_set_keymap('n', '<C-j>', ':BufferClose<CR>', { noremap = true, silent = true })
        -- Restore buffer
        vim.api.nvim_set_keymap('n', '<C-k>', ':BufferRestore<CR>', { noremap = true, silent = true })
    end
}
