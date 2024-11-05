return {
    "FabijanZulj/blame.nvim",
    config = function()
        require("blame").setup()

        -- Keymap
        vim.api.nvim_set_keymap("n", "<F3>", "<cmd>BlameToggle<CR>", { noremap = true, silent = true })
    end
}
