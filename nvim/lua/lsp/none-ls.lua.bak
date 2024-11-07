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
                -- Pritter
                null_ls.builtins.formatting.prettierd,
            }
        })
    end,
}
