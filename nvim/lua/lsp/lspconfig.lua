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
        -- 'blade-formatter',
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
        -- 'fixjson',
        'yamlls',
        'gh_actions_ls',
      },
      automatic_enable = {
        exclude = {
          'jdtls' -- lang/nvim-jdtlsでセットアップしているので, TODO: 統合する
        }
      }
    }

    -- TODO: 別のファイルに分割する?, /lspディレクトリを使って設定できるようになったらしいのでその方法にする?

    local capabilities = require('lsp.external.handler').capabilities
    local on_attach = require('lsp.external.handler').on_attach

    -- Common
    vim.lsp.config('*', {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- TS(with Vue)
    local vue_ts_plugin = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")
    vim.lsp.config('ts_ls', {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_ts_plugin,
            languages = { "javascript", "typescript", "vue" },
            configNamespace = 'typescript'
          },
        },
      },
      filetypes = {
        "javascript", "typescript", "vue", "typescriptreact", "javascriptreact", "typescript.tsx", "javascript.jsx"
      },
    })

    vim.lsp.config('vue_ls', {
      filetypes = { 'vue' },
    })

    -- PHP
    vim.lsp.config('intelephense', {
      filetypes = { 'php', 'blade' },
    })

    -- CSS/Tailwind
    vim.lsp.config('cssls', {
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })

    vim.lsp.config('somesass_ls', {
      settings = {
        somesass = {
          scss = {
            diagnostics = {
              lint = {
                -- ドキュメントには無いけど何故か使える？？
                -- https://code.visualstudio.com/docs/languages/css#_customizing-css-scss-and-less-settings
                unknownAtRules = "ignore",
              },
            },
          },
        },
      },
    })

    -- Rust
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = "clippy",
          },
        },
      },
    })
  end,
}
