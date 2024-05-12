local M = {}
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local signature_cfg = {
    bind = false,
    doc_lines = 2,
    floating_window = true,
    hint_enable = true,
    hint_prefix = "💡",
    use_lspsaga = true;
    max_height = 22,
    max_width = 120,
    handler_opts = {
        border = 'single',
    },
}

local function set_signature_helper(client, bufnr)
    local shp = client.server_capabilities.signatureHelpProvider
    if shp == true or (type(shp) == "table" and next(shp) ~= nil) then
        require("lsp_signature").on_attach(signature_cfg, bufnr)
    end
end

local function set_hover_border(client)
    local hp = client.server_capabilities.hoverProvider
    if hp == true or (type(hp) == "table" and next(hp) ~= nil) then
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    end
end

M.on_attach = function(client, bufnr)
    set_signature_helper(client, bufnr)
    set_hover_border(client)

	-- Keybindings
	vim.keymap.set('n', '<Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', '<S-d>', '<cmd>lua vim.lsp.buf.definition()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'efm', '<cmd>lua vim.lsp.buf.format()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'erf', '<cmd>lua vim.lsp.buf.references()<CR>', { remap = true, buffer = bufnr })
	vim.keymap.set('n', 'ern', '<cmd>lua vim.lsp.buf.rename()<CR>', { remap = true, buffer = bufnr })
	-- vim.keymap.set('n', 'efx', '<cmd>lua vim.lsp.buf.code_action()<CR>', { remap = true, buffer = bufnr })

	-- Rewrite LSP saga
	vim.keymap.set('n', 'efx', '<cmd>Lspsaga code_action<CR>', { remap = true, buffer = bufnr })
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities = require('coq').lsp_ensure_capabilities()
return M
