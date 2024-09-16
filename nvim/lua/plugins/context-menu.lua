local function callCmd(cmd)
    vim.cmd(cmd)
end

local function callLspsaga(cmd)
    callCmd("Lspsaga " .. cmd)
end

return {
    -- 'LintaoAmons/context-menu.nvim',
    -- dir = '/Users/rca/proj/context-menu.nvim',
    'r-ca/context-menu.nvim',
    config = function()
        require('context-menu').setup({
            menu_items = {
                {
                    order = 1,
                    cmd = "🔌 LSP",
                    action = {
                        type = "sub_cmds",
                        sub_cmds = {
                            {
                                cmd = "Preview Definition",
                                action = {
                                    type = "callback",
                                    callback = function()
                                        callLspsaga("peek_definition")
                                    end
                                }
                            },
                            {
                                cmd = "Finder",
                                filter_func = function(context)
                                    -- return require('utils').lspCapability.check_capability("referencesProvider")
                                    return nil
                                end,
                                action = {
                                    type = "callback",
                                    callback = function()
                                        callLspsaga("finder")
                                    end
                                }
                            },
                            {
                                cmd = "Outline",
                                action = {
                                    type = "callback",
                                    callback = function()
                                        callLspsaga("outline")
                                    end
                                }
                            },
                        }
                    }
                },
                {
                    order = 2,
                    cmd = "⚙️  Debug",
                    action = {
                        type = "sub_cmds",
                        sub_cmds = {
                            {
                                cmd = "Get capabilities",
                                action = {
                                    type = "callback",
                                    callback = function()
                                        require("utils").lspCapability.check_capability("textDocument/definition")
                                    end
                                }
                            }
                        }
                    }
                }
            },
            default_action_keymaps = {
                close_menu = { 'q', '<esc>' },
                trigger_action = { '<SPACE>', '<CR>' },
            }
        })

        -- Keymaps
        vim.api.nvim_set_keymap('n', '<space>', "<cmd> lua require('context-menu').trigger_context_menu() <cr>",
            { noremap = false, silent = true })
    end
}
