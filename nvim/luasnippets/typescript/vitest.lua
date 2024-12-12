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
      t("test('"),
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

  -- beforeAllブロック: "vitest.ba" または "vitest.ba:name"
  s(
    { trig = "vitest%.ba:?(.*)", regTrig = true, wordTrig = false },
    {
      t("beforeAll(() => {"),
      t({"", "  "}),
      i(1, "// beforeAll の処理を記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),

  -- beforeEachブロック: "vitest.be" または "vitest.be:name"
  s(
    { trig = "vitest%.be:?(.*)", regTrig = true, wordTrig = false },
    {
      t("beforeEach(() => {"),
      t({"", "  "}),
      i(1, "// beforeEach の処理を記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),

  -- afterAllブロック: "vitest.aa" または "vitest.aa:name"
  s(
    { trig = "vitest%.aa:?(.*)", regTrig = true, wordTrig = false },
    {
      t("afterAll(() => {"),
      t({"", "  "}),
      i(1, "// afterAll の処理を記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),

  -- afterEachブロック: "vitest.ae" または "vitest.ae:name"
  s(
    { trig = "vitest%.ae:?(.*)", regTrig = true, wordTrig = false },
    {
      t("afterEach(() => {"),
      t({"", "  "}),
      i(1, "// afterEach の処理を記述"),
      t({"", "});"}),
    },
    { condition = is_test_file }
  ),
}
