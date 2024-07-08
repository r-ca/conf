return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local null_ls = require("null-ls");
        require("null-ls").setup({
            sources = {
                -- ESLint
                require("none-ls.diagnostics.eslint_d"),
                require("none-ls.code_actions.eslint_d"),
                require("none-ls.formatting.eslint_d"),
                -- Pritter
                null_ls.builtins.formatting.prettierd,
            }
        })
    end,
}
