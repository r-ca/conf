local lsp_list = function()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
    if client.name == 'null-ls' then
      local sources = {}
      for _, source in ipairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
        table.insert(sources, source.name)
      end
      table.insert(clients, 'null-ls(' .. table.concat(sources, ', ') .. ')')
    else
      table.insert(clients, client.name)
    end
  end
  return ' ' .. table.concat(clients, ', ')
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'ayu',
        globalstatus = true,
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          -- { 'mode', separator = { left = '' }, right_padding = 2 },
          { 'mode', right_padding = 2 },
        },
        lualine_b = {
          { 'filetype', right_padding = 2 },
          { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' }, right_padding = 2 },
        },
        lualine_c = {
          { 'filename',   file_status = true, path = 1 },
          { 'encoding' },
          { 'diagnostics' },
        },
        lualine_x = {
          { lsp_list, right_padding = 2 }
        },
        lualine_y = {
          { 'progress', right_padding = 2 },
          { 'location', right_padding = 2 },
        },
        lualine_z = {
          -- { 'branch', icon = '', separator = { right = '' }, left_padding = 2 },
          { 'branch', icon = '', left_padding = 2 },
        },
      }
    })
  end
}
