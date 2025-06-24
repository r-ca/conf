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
        sn(nil, { i(1, "type") }),
      }),
      t(" "),
      i(2, "function_name"),
      t("("),
      -- 引数の選択
      c(3, {
        t("void"),
        t("int argc, char const *argv[]"),
        sn(nil, { i(1, "params") }),
      }),
      t({ ") {", "\t" }),
      i(4, "// TODO: implement"),
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
      -- ① 型の選択
      c(1, {
        t("int"),
        t("char"),
        t("float"),
        t("double"),
        t("char *"),
        sn(nil, { i(1, "type") }),
      }),
      t(" "),
      i(2, "name"),
      t(" "),
      -- ② スカラー or 配列 or 配列＋初期化 の選択
      c(3, {
        -- scalar: int foo = 0;
        sn(nil, { t("= "), i(1, "0"), t(";") }),
        -- array without initializer: int foo[ size ];
        sn(nil, { t("["), i(1, "size"), t("];") }),
        -- array with initializer: int foo[ size ] = { values };
        sn(nil, {
          t("["), i(1, "size"), t("] = { "),
          i(2, "values"),
          t(" };"),
        }),
      }),
    }
  ),
}
