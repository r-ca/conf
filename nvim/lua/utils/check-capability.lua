local M = {}

-- 現在のバッファに対して引数のアクションが実行可能なクライアントがあるかどうかを返す
function M.check_capability(action)
    local clients = vim.lsp.buf_get_clients(0)
    for _, client in pairs(clients) do
        if client.server_capabilities[action] then
            return true
        end
    end
    return false
end

return M
