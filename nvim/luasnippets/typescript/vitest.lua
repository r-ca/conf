local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

-- テストファイル判定関数
local function is_test_file()
  local filename = vim.fn.expand("%:t")
  return filename:match("%.test%.ts$") ~= nil
end

return {
  -- describeブロック: "vitest.de" または "vitest.de:name"
  s(
    { trig = "vitest%.de:?(.*)", regTrig = true, wordTrig = false },
    {
      t("describe('"),
      d(1, function(args, parent)
        -- captures[1]には':name'の'name'部分が入る。なければ空文字
        local name = parent.snippet.captures[1] or ""
        if name == "" then
          -- 名前がない場合はinsert_nodeで入力可能にする
          return sn(nil, i(1, "テスト名"))
        else
          -- 名前がある場合はそのままテキストを挿入
          return sn(nil, t(name))
        end
      end, {}),
      t("', () => {"),
      t({"", "  "}),
      i(0, "// テストブロック内にコードを記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),

  -- itブロック: "vitest.te" または "vitest.te:name"
  s(
    { trig = "vitest%.te:?(.*)", regTrig = true, wordTrig = false },
    {
      t("it('"),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1] or ""
        if name == "" then
          return sn(nil, i(1, "テスト名"))
        else
          return sn(nil, t(name))
        end
      end, {}),
      t("', () => {"),
      t({"", "  "}),
      i(0, "// テストコードを記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),
}
