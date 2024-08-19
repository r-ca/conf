return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function ()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["<SPACE>"] = "open",
                    -- ["<SPACE>p"] = "image_wezterm"

                }
            },
            commands = {
                image_wezterm = function(state)
                    local node = state.tree:get_node()
                    if node.type == "file" then
                        require("image_preview").PreviewImage(node.path)
                    end
                end,
            },
        });


        vim.api.nvim_set_keymap('n', 'tf', '<cmd>Neotree toggle<CR>', { noremap = true, silent = true })
    end
}
