local M = {}

-- パンくずリストを生成する
function M.create(path)
    return table.concat(path, "  ")
end

return M
