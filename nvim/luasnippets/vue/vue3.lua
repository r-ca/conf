local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

return {
  -- Setup empty Vue3 component
  s(
    { trig = "vuet", regTrig = false, wordTrig = false },
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
}
