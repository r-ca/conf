return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
                ensure_installed = "all",
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				-- autotag = { enable = true },
			})
		end
	}
}
