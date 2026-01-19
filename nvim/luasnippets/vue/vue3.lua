local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

return {
  -- Setup empty Vue3 component
  s(
    { trig = "vuecomp", regTrig = false, wordTrig = false },
    {
      t("<template>"),
      t({ "", "  " }), i(1, "コンポーネントHTML"), t({ "", "</template>", "" }),
      t("<script setup lang=\"ts\">"), t({ "", "" }),
      i(2, "// script setup 内の処理"),
      t({ "", "</script>", "" }),
      t("<style scoped>"), t({ "", "" }),
      i(3, "/* スタイル */"),
      t({ "", "</style>" }),
    }
  ),

  -- unscoped style tag
  s(
    { trig = "style", regTrig = false, wordTrig = false },
    {
      t("<style>"), t({ "", "" }),
      i(1, "/* スタイル */"),
      t({ "", "</style>" }),
    }
  ),

  -- scoped style tag
  s(
    { trig = "styles", regTrig = false, wordTrig = false },
    {
      t("<style scoped>"), t({ "", "" }),
      i(1, "/* スタイル */"),
      t({ "", "</style>" }),
    }
  ),

}
