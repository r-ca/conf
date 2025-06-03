local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node

return {
  -- include スニペット: "incl"
  s(
    { trig = "incl", regTrig = false, wordTrig = true },
    {
      c(1, {
        t("#include <stdio.h>"),
        t("#include \"header.h\""),
      }),
      i(0), -- 最後に置く
    }
  ),

  -- 関数テンプレート: "func"
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- ① 戻り値型の選択（int / void / char * / 自由入力）
      c(1, {
        t("int"),
        t("void"),
        t("char *"),
        i(1, "type"),
      }),
      t(" "), i(2, "function_name"), t("("), i(3, "void"), t({ ") {", "  " }),
      i(4, ""), -- 関数本体の先頭
      t({ "", "}" }),
      i(0),     -- ここでスニペットを抜ける
    }
  ),

  -- printf 用スニペット: "print"
  s(
    { trig = "print", regTrig = false, wordTrig = true },
    {
      c(1, {
        t("printf(\"format\");"),
        t("printf(\"format\", args);"),
      }),
      i(0),
    }
  ),

  -- scanf 用スニペット: "scan"
  s(
    { trig = "scan", regTrig = false, wordTrig = true },
    {
      c(1, {
        t("scanf(\"%d\", &var);"),
        t("scanf(\"%d %f\", &i, &f);"),
      }),
      i(0),
    }
  ),

  -- 変数宣言スニペット: "var"
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      c(1, {
        t("int"),
        t("char"),
        t("float"),
        t("double"),
        t("char *"),
        i(1, "type"),
      }),
      t(" "), i(2, "name"), t(" "),
      c(3, {
        -- スカラー: int foo = 0;
        t("= 0;"),
        -- 配列（初期化なし）: int foo[size];
        t("[size];"),
        -- 配列＋初期化: int foo[size] = { values };
        t("[size] = { values };"),
      }),
      i(0),
    }
  ),

  -- プロトタイプ用スニペット: "proto"
  s(
    { trig = "proto", regTrig = false, wordTrig = true },
    {
      -- ① 戻り値型の選択（int / void / char * / 自由入力）
      c(1, {
        t("int"),
        t("void"),
        t("char *"),
        i(1, "type"),
      }),
      t(" "), i(2, "function_name"), t("("), i(3, "void"), t(");"),
      i(0),
    }
  ),
}
