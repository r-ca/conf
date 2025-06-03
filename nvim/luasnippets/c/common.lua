local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local sn = ls.snippet_node

return {
  -- C の #include スニペット: "inc"
  s(
    { trig = "inc", regTrig = false, wordTrig = true },
    {
      t("#include "),
      c(1, {
        sn(nil, { t("<"), i(1, "stdio.h"), t(">") }),    -- <stdio.h>
        sn(nil, { t("\""), i(1, "header.h"), t("\"") }), -- "header.h"
      }),
    }
  ),

  -- C の基本的な関数テンプレート: "fnc"
  s(
    { trig = "fnc", regTrig = false, wordTrig = true },
    {
      -- 戻り値の型
      c(1, {
        t("void"),
        t("int"),
        t("char *"),
        i(nil, "type"), -- カスタムで型を入力したい場合
      }),
      t(" "),
      -- 関数名
      i(2, "func_name"),
      t("("),
      -- 引数リスト（デフォルトは空、必要に応じて書き換え）
      i(3, "void"),
      t(")"),
      t({ " {", "    " }),
      -- 関数本体
      i(0),
      t({ "", "}" }),
    }
  ),
}
