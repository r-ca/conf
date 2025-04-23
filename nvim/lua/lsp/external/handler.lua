local M = {}
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local signature_cfg = {
  bind = false,
  doc_lines = 2,
  floating_window = true,
  hint_enable = true,
  hint_prefix = "💡",
  use_lspsaga = true,
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
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
return M
