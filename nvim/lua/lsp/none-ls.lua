return {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls");
        require("null-ls").setup({
            sources = {
                -- ESLint
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.formatting.eslint_d,
                -- Pritter
                null_ls.builtins.formatting.prettierd,
            }
        })
    end,
}
