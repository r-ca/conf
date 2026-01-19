return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/vim-vsnip' },
    { 'hrsh7th/cmp-vsnip' },
    { 'onsails/lspkind-nvim' },
    { 'zbirenbaum/copilot-cmp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'ray-x/cmp-sql' },
    { 'hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-emoji' },
    { 'saadparwaiz1/cmp_luasnip' },
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
        { name = 'cmp_tabnine' },
        { name = 'nvim_lua' },
        { name = 'sql' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'luasnip' },
      },

      formatting = {
        format = function(entry, item)
          -- `nvim-highlight-colors`によるフォーマット
          local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

          -- `lspkind`のフォーマット設定
          item = require("lspkind").cmp_format({
            mode = 'symbol_text',
            symbol_map = {
              Copilot = '',
              TabNine = '󰋙', -- 似てるので
              sql = '',
            },
          })(entry, item)

          -- 色情報があればそれを適用
          if color_item.abbr_hl_group then
            item.kind_hl_group = color_item.abbr_hl_group
            item.kind = color_item.abbr
          end

          return item
        end
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
