local function parse_version(v)
  local t = {}
  for num in string.gmatch(v, "(%d+)") do
    table.insert(t, tonumber(num))
  end
  return t
end

local function version_lt(a, b)
  local va, vb = parse_version(a), parse_version(b)
  for i = 1, 3 do
    if va[i] ~= vb[i] then
      return va[i] < vb[i]
    end
  end
  return false
end

local function find_latest_volta_node()
  local base = vim.fn.expand("~/.volta/tools/image/node")
  if vim.fn.isdirectory(base) == 0 then
    return nil
  end

  local dirs = vim.fn.systemlist(("ls -1 %s"):format(base))
  local candidates = {}

  for _, d in ipairs(dirs) do
    local major = tonumber(d:match("^(%d+)"))
    if major and major >= 20 then
      table.insert(candidates, d)
    end
  end

  if #candidates == 0 then
    return nil
  end

  table.sort(candidates, version_lt)
  local latest = candidates[#candidates]
  return ("%s/%s/bin/node"):format(base, latest)
end

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = "InsertEnter",
  config = function()
    local node_path = os.getenv("COPILOT_LUA_NODE_PATH")
        or find_latest_volta_node()
        or "node" -- fallback to system node

    require('copilot').setup({
      copilot_node_command = node_path,
      panel = { enabled = false },
      suggestion = { enabled = false },
    })
  end
}
