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
                        type = "function",
                        fn = function()
                            print("Hello world!")
                        end
                    }
                }
            }
        })

        -- Keymaps
        vim.api.nvim_set_keymap('n', '<F9>', "<cmd> lua require('context-menu').trigger_context_menu() <cr>", { noremap = true, silent = true })
    end
}
