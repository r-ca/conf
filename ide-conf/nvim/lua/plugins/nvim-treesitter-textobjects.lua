return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,

                    -- -- Automatically jump forward to textobj, similar to targets.vim
                    -- lookahead = true,

                    keymaps = {
                        -- Built-in captures.
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    },
                },
            },
        })
    end,
}
