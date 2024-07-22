return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/vim-vsnip'},
		{'hrsh7th/cmp-vsnip'},
        {'onsails/lspkind-nvim'},
        {'zbirenbaum/copilot-cmp'},
        {'Jezda1337/nvim-html-css'},
    },
    config = function()
        require('cmp').setup({
			snippet = {
				expand = function(args)
					vim.fn['vsnip#anonymous'](args.body)
				end,
			},

            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'vsnip' },
                { name = 'copilot' },
                { name = 'html-css' },
            },

            formatting = {
				format = require('lspkind').cmp_format({
					with_text = true,
					maxwidth = 120,
				})
			},

            mapping = {
                ['<C-j>'] = require('cmp').mapping(function(fallback)
                    if require('cmp').visible() then
                        require('cmp').select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<C-k>'] = require('cmp').mapping(function(fallback)
                    if require('cmp').visible() then
                        require('cmp').select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<C-CR>'] = require('cmp').mapping.confirm({
                    behavior = require('cmp').ConfirmBehavior.Insert,
                    select = true,
                }),
            }
        })
    end
}
