return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'folke/neoconf.nvim',
    'mrjones2014/codesettings.nvim',
  },

  config = function()
    require('mason-lspconfig').setup {
      ensure_installed = {
        -- CSS
        'cssls',
        'css_variables',
        'cssmodules_ls',
        -- Docker/Docker-compose
        'dockerls',
        'docker_compose_language_service',
        -- HTML
        'html',
        -- PHP
        'intelephense',
        -- 'blade-formatter',
        -- JavaScript/TypeScript and related
        'ts_ls',
        'prismals',
        -- 'tailwindcss',
        'vue_ls',
        -- Rust
        'rust_analyzer',
        -- Python
        'jedi_language_server',
        -- Java
        'jdtls',
        -- Common
        'jsonls',
        -- 'fixjson',
        'yamlls',
        'gh_actions_ls',
      },
      automatic_enable = {
        exclude = {
          'jdtls' -- lang/nvim-jdtlsでセットアップしているので, TODO: 統合する
        }
      },
    }

    -- TODO: 別のファイルに分割する?, /lspディレクトリを使って設定できるようになったらしいのでその方法にする?

    local capabilities = require('lsp.external.handler').capabilities
    local on_attach = require('lsp.external.handler').on_attach

    -- Common
    vim.lsp.config('*', {
      before_init = function(_, config)
        local codesettings = require('codesettings')
        codesettings.with_local_settings(config.name, config)

        -- local settings = codesettings.local_settings()
        -- local disabled = settings:get('disabledLs')
        -- vim.notify(vim.inspect(disabled))
        -- vim.notify(vim.inspect(config.name))
        -- if disabled and vim.tbl_contains(disabled, config.name) then
        --   vim.notify(string.format("LSP '%s' is disabled by codesettings.nvim", config.name), vim.log.levels.INFO)
        --   return false  -- Prevent LSP from starting
        -- end
      end,
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.enable('sourcekit')
  end,
}
