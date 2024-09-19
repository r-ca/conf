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
                                filter_func = function()
                                    local lspCapability = require('utils').lspCapability
                                    if lspCapability.check_capability("referencesProvider")
                                        or lspCapability.check_capability("definitionProvider")
                                        or lspCapability.check_capability("implementationProvider") then
                                        return true
                                    end
                                end,
                                action = {
                                    type = "callback",
                                    callback = function()
                                        local args = { "" }
                                        local lspCapability = require('utils').lspCapability
                                        if lspCapability.check_capability("referencesProvider") then
                                            args = { "ref" }
                                        end
                                        if lspCapability.check_capability("definitionProvider") then
                                            args = { "def" }
                                        end
                                        if lspCapability.check_capability("implementationProvider") then
                                            args = { "imp" }
                                        end
                                        callLspsaga("finder " .. table.concat(args, "+"))
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
                    cmd = "🖇️ Git Message",
                    action = {
                        type = "callback",
                        callback = function()
                            callCmd("GitMessenger")
                        end
                    },
                },
                {
                    order = 3,
                    cmd = "Generate annotation(Neogen)",
                    action = {
                        type = "callback",
                        callback = function()
                            require('neogen').generate()
                        end
                    }
                },
            },
            default_action_keymaps = {
                close_menu = { 'q', '<esc>' },
                trigger_action = { '<SPACE>', '<CR>' },
            }
        })
        -- Keymaps
        vim.api.nvim_set_keymap('n', '<C-space>', "<cmd> lua require('context-menu').trigger_context_menu() <cr>",
            { noremap = false, silent = true })
    end
}
