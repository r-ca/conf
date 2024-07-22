return {
    "Jezda13337/nvim-html-vss",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("nvim-html-css").setup();
    end,
}
