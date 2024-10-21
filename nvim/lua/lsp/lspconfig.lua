return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'williamboman/mason.nvim',
    },
    config = function()
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local lspconfig = require('lspconfig')

        local capabilities = require('lsp.external.handler').capabilities;
        local on_attach = function(client, bufnr)
            require('lsp.external.handler').on_attach(client, bufnr)
        end


        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = {
                "cssls",
                "css_variables",
                "cssmodules_ls",
                "docker_compose_language_service",
                "dockerls",
                -- "gopls",
                "html",
                "intelephense",
                "jdtls",
                "prismals",
                "ts_ls",
                "volar",
                "yamlls",
                "lua_ls"
            },
        })
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    -- autostart = true,
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,

            -- Javaは別で設定しているので
            jdtls = function()
            end,

            ts_ls = function()
                local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server")
                    :get_install_path() .. "/node_modules/@vue/language-server"
                -- local vue_typescript_plugin = os.getenv("HOME") .. "/.local/share/mise/installs/node/20/lib/node_modules/@vue/language-server"
                lspconfig.ts_ls.setup({
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vue_typescript_plugin,
                                languages = { "javascript", "typescript", "vue" },
                            },
                        },
                    },
                    filetypes = {
                        "javascript", "typescript", "vue"
                    },
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
        })
    end,
}
