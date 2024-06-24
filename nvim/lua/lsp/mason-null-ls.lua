return {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
        require("mason-null-ls").setup({
            automatic_installation = true,
            handlers = {},
        })

        require("null-ls").setup({
        })
    end,
}
