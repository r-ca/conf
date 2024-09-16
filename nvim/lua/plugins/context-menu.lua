return {
    'LintaoAmons/context-menu.nvim',
    config = function()
        require('context-menu').setup({
            close_menu = { 'q', '<esc>' },
            menu_items = {
                {
                    order = 1,
                    cmd = "Hello world!",
                    action = {
                        type = "callback",
                        callback = function()
                            print("Hello world!")
                        end
                    }
                },
                {
                    order = 2,
                    cmd = "Hello world 2!",
                    action = {
                        type = "sub_cmds",
                        sub_cmds = {
                            {
                                cmd = "Hello world 2.1!",
                                action = {
                                    type = "callback",
                                    callback = function()
                                        print("Hello world 2.1!")
                                    end
                                }
                            },
                            {
                                cmd = "Hello world 2.2!",
                                action = {
                                    type = "callback",
                                    callback = function()
                                        print("Hello world 2.2!")
                                    end
                                }
                            }
                        }
                    },
                }
            }
        })

        -- Keymaps
        vim.api.nvim_set_keymap('n', '<Space>', "<cmd> lua require('context-menu').trigger_context_menu() <cr>",
            { noremap = true, silent = true })
    end
}
