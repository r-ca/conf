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
                                filter_func = function(context)
                                    local lspCapability = require('utils').lspCapability
                                    return lspCapability.check_capability("definitionProvider", context.buffer)
                                end,
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
                                    local lspCapability = require('utils').lspCapability
                                    local test =  not (
                                        lspCapability.check_capability("referencesProvider", context.buffer)
                                        or lspCapability.check_capability("definitionProvider", context.buffer)
                                        or lspCapability.check_capability("implementationProvider", context.buffer)
                                    )
                                    return test
                                end,
                                action = {
                                    type = "callback",
                                    callback = function(context)
                                        local args = {}
                                        local lspCapability = require('utils').lspCapability
                                        if lspCapability.check_capability("referencesProvider", context.buffer) then
                                            table.insert(args, "ref")
                                        end
                                        if lspCapability.check_capability("definitionProvider", context.buffer) then
                                            table.insert(args, "def")
                                        end
                                        if lspCapability.check_capability("implementationProvider", context.buffer) then
                                            table.insert(args, "imp")
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
