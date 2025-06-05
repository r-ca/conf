return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
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
        'blade-formatter',
        -- JavaScript/TypeScript and related
        'ts_ls',
        'prismals',
        'tailwindcss',
        'vue_ls',
        -- Rust
        'rust_analyzer',
        -- Python
        'jedi_language_server',
        -- Java
        'jdtls',
        -- Common
        'jsonls',
        'fixjson',
        'yamlls',
        'gh_actions_ls',
      },
      automatic_enable = {
        exclude = {
          'jdtls' -- lang/nvim-jdtlsでセットアップしているので, TODO: 統合する
        }
      }
    }
  end,
}
