
local floating_menu = require("testing.floating-menu.floating_menu")
local main_menu = require("testing.floating-menu.menu_definitions")

vim.api.nvim_set_keymap("n", "<F12>", "", {
    callback = function() floating_menu.OpenFloatingMenu(main_menu) end,
    noremap = true,
    silent = true,
})

