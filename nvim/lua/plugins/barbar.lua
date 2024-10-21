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
    end
}
