local ls = require("luasnip")
local s  = ls.snippet
local sn = ls.snippet_node
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node

return {
  -- include スニペット: "incl"
  s(
    { trig = "incl", regTrig = false, wordTrig = true },
    {
      c(1, {
        sn(nil, { t("#include <"), i(1, "stdio.h"), t(">") }),
        sn(nil, { t("#include \""), i(1, "header.h"), t("\"") }),
      }),
    }
  ),

  -- 関数テンプレート: "func"
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- 戻り値型の選択
      c(1, {
        t("int"),
        t("void"),
        t("char *"),
        i(1, "type"),
      }),
      t(" "), i(2, "function_name"), t("("), i(3, "void"), t({ ") {", "  " }),
      i(4, ""),
      t({ "", "}" }),
    }
  ),

  -- printf 用スニペット: "print"
  s(
    { trig = "print", regTrig = false, wordTrig = true },
    {
      c(1, {
        sn(nil, { t("printf(\""), i(1, "format"), t("\");") }),
        sn(nil, { t("printf(\""), i(1, "format"), t("\", "), i(2, "args"), t(");") }),
      }),
    }
  ),

  -- scanf 用スニペット: "scan"
  s(
    { trig = "scan", regTrig = false, wordTrig = true },
    {
      c(1, {
        sn(nil, { t("scanf(\""), i(1, "%d"), t("\", &"), i(2, "var"), t(");") }),
        sn(nil, { t("scanf(\""), i(1, "%d %f"), t("\", &"), i(2, "i"), t(", &"), i(3, "f"), t(");") }),
      }),
    }
  ),

  -- 変数宣言スニペット: "var"
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      -- 型の選択
      c(1, {
        t("int"),
        t("char"),
        t("float"),
        t("double"),
        t("char *"),
        i(1, "type"),
      }),
      t(" "), i(2, "name"), t(" "),
      -- スカラー or 配列 の選択
      c(3, {
        sn(nil, { t("= "), i(1, "0"), t(";") }),
        sn(nil, { t("["), i(1, "size"), t("];") }),
      }),
    }
  ),
}
