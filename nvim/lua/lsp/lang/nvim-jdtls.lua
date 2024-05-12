return {
    'mfussenegger/nvim-jdtls',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    ft = { 'java' },
    config = function()
        local share_dir = os.getenv('HOME') .. '/.local/share'
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = share_dir .. '/eclipse/' .. project_name
        local java_bin = function()
            local java_home = os.getenv('JAVA_HOME')
            if java_home == nil then
                return 'java'
            end
            return java_home .. '/bin/java'
        end
        local mason_registry = require('mason-registry')
        local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()
        local on_attach = function(client, bufnr)
            require('lsp.external.handler').on_attach(client, bufnr)
        end
        local capabilities = require('lsp.external.handler').capabilities
        local extended_capabilities = require('jdtls').extendedClientCapabilities
        extended_capabilities.resolveAdditionalTextEditsSupport = true
        local user_home = os.getenv('HOME')
        local lombok_path = vim.fn.glob(user_home .. '/.config/nvim/lib/lombok*.jar')
        local equinox_launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
        -- local equinox_launcher = vim.fn.globpath(jdtls_path, 'org.eclipse.equinox.launcher_*.jar')[1]
        -- local equinox_launcher = jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'
        local config_os = function()
            if vim.fn.has('mac') == 1 then
                return jdtls_path .. '/config_mac'
            elseif vim.fn.has('unix') == 1 then
                return jdtls_path .. '/config_linux'
            elseif vim.fn.has('win64') == 1 then
                return jdtls_path .. '/config_win'
            end
        end

        local config = {
            autostart = true,
            filetypes = { 'java' },
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
            -- launcher_path = vim.fn.globpath(jdtls_path, 'org.eclipse.equinox.launcher_*.jar')[1],
            single_file_support = true,
            flags = {
                allow_incremental_sync = true,
            },
            settings = {
                java ={
                    eclipse = {
                        downloadSources = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    contentProvider = {
                        preferred = 'fernflower',
                    },
                    signatureHelp = {
                        enabled = true,
                    },
                    completion = {
                        favoriteStaticMembers = {
                            "org.hamcrest.MatcherAssert.assertThat",
                            "org.hamcrest.Matchers.*",
                            "org.hamcrest.CoreMatchers.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "java.util.Objects.requireNonNull",
                            "java.util.Objects.requireNonNullElse",
                            "org.mockito.Mockito.*"
                        }
                    },
                    configuration = {
                        updateBuildConfiguration = 'interactive',
                    },
                    maven = {
                        downloadSources= true
                    },
                    inlayHints = {
                        parameterNames = {
                            enabled = 'all'
                        }
                    },
                    extendedClientCapabilities = extended_capabilities,
                    sources = {
                        organizeImports = {
                            -- onSave = true,
                            starThreshold = 9999,
                            staticStarThreshold = 9999
                        }
                    }
                }
            },
            cmd = {
                java_bin(),

                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx16g',
                '-javaagent:' .. lombok_path,
                '-jar', equinox_launcher,
                '-configuration', config_os(),
                '-data', workspace_dir,
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            }
        }

        vim.api.nvim_create_augroup('java-ls',{ clear = true })
        vim.api.nvim_create_autocmd(
            {
                'FileType'
            },{
                pattern = 'java',
                group = 'java-ls',
                callback = function()
                    require('jdtls').start_or_attach(config)
                end
            }
        )
        require('jdtls').start_or_attach(config)
    end
}
