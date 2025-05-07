local function h(name)
  return vim.api.nvim_get_hl(0, { name = name })
end
--
-- vim.api.nvim_set_hl(0, 'SymbolUsageRounding', {
--   fg     = h('CursorLine').bg,
--   italic = true,
-- })
--
-- vim.api.nvim_set_hl(0, 'SymbolUsageContent', {
--   fg     = h('CursorLine').fg,
--   bg     = h('CursorLine').bg,
--   italic = true,
-- })
--
-- vim.api.nvim_set_hl(0, 'SymbolUsageRef', {
--   fg     = h('Function').fg,
--   bg     = h('CursorLine').bg,
--   italic = true,
-- })
--
-- vim.api.nvim_set_hl(0, 'SymbolUsageDef', {
--   fg     = h('Type').fg,
--   bg     = h('CursorLine').bg,
--   italic = true,
-- })
--
-- vim.api.nvim_set_hl(0, 'SymbolUsageImpl', {
--   fg     = h('@keyword').fg,
--   bg     = h('CursorLine').bg,
--   italic = true,
-- })
--
local function text_format(symbol)
  local res = {}

  local round_start = { '', 'SymbolUsageRounding' }
  local round_end = { '', 'SymbolUsageRounding' }

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0
      and ("+%s"):format(symbol.stacked_count)
      or ''

  if symbol.references then
    local usage = symbol.references <= 1 and 'usage' or 'usages'
    local num = symbol.references == 0 and 'no' or symbol.references
    table.insert(res, round_start)
    table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
    table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
    table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
    table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if stacked_functions_content ~= '' then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { ' ', 'SymbolUsageImpl' })
    table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  return res
end

return {
  'Wansmer/symbol-usage.nvim',
  config = function()
    require('symbol-usage').setup({
      text_format = text_format,
      vt_position = 'above',
      request_pending_text = 'Pending...',
    })
    -- ハイライト定義を関数化
    local function apply_symbol_usage_hl()
      local h = function(name) return vim.api.nvim_get_hl(0, { name = name }) end
      vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true, blend = 20 })
      vim.api.nvim_set_hl(0, 'SymbolUsageContent',
        { fg = h('CursorLine').fg, bg = h('CursorLine').bg, italic = true, blend = 20 })
      vim.api.nvim_set_hl(0, 'SymbolUsageRef',
        { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true, blend = 20 })
      vim.api.nvim_set_hl(0, 'SymbolUsageDef',
        { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true, blend = 20 })
      vim.api.nvim_set_hl(0, 'SymbolUsageImpl',
        { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true, blend = 20 })
    end

    -- 起動時にも一度適用
    apply_symbol_usage_hl()

    -- カラー・スキーム変更後にも再適用
    vim.api.nvim_create_augroup('SymbolUsageHighlights', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group    = 'SymbolUsageHighlights',
      callback = apply_symbol_usage_hl,
    })
  end
}
