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
        mason_lspconfig.setup()
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    autostart = true,
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
        })
    end,
}
