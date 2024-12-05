local floating_menu = require("testing.floating-menu.floating_menu")

local sub_menu = {
    title = "Sub Menu",
    sections = {
        {
            title = "Sub Options",
            items = {
                { text = "Sub Option 1", icon = "🔹", action = function() print("Sub Option 1 selected!") end },
                { text = "Back to Main", icon = "⬅️", action = function() floating_menu.OpenFloatingMenu(main_menu, { "Main Menu" }) end },
            },
        },
    },
    width = 60,
    padding = 4,
}

local main_menu = {
    title = "Main Menu",
    sections = {
        {
            title = "General Options",
            items = {
                { text = "Do Something", icon = "✅", action = function() print("Doing something!") end },
                { text = "Open Sub Menu", icon = "📂", action = function() floating_menu.OpenFloatingMenu(sub_menu, { "Main Menu", "Sub Menu" }) end },
            },
        },
        {
            title = "Exit",
            items = {
                { text = "Quit", icon = "🚪", action = function() print("Goodbye!") end },
            },
        },
    },
    width = 60,
    padding = 4,
}

return main_menu

