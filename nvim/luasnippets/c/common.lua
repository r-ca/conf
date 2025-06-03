local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local sn = ls.snippet_node

return {
  -- C の #include スニペット: "include"
  s(
    { trig = "include", regTrig = false, wordTrig = true },
    {
      t("#include "),
      c(1, {
        sn(nil, { t("<"), i(1, "stdio.h"), t(">") }),    -- <stdio.h>
        sn(nil, { t("\""), i(1, "header.h"), t("\"") }), -- "header.h"
      }),
    }
  ),

  -- C の基本的な関数テンプレート: "func"
  -- 戻り値型のデフォルトを int にしておく
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- 戻り値の型（デフォルトは int）
      c(1, {
        t("int"),
        t("void"),
        t("char *"),
        i(nil, "type"), -- カスタム型
      }),
      t(" "),
      -- 関数名
      i(2, "function_name"),
      t("("),
      -- 引数リスト（デフォルトは void）
      i(3, "void"),
      t(")"),
      t({ " {", "    " }),
      -- 関数本体
      i(0),
      t({ "", "}" }),
    }
  ),

  -- printf スニペット: "print"
  s(
    { trig = "print", regTrig = false, wordTrig = true },
    {
      c(1, {
        -- フォーマット文字列だけ
        sn(nil, {
          t("printf(\""), i(1, "format"), t("\");"),
        }),
        -- フォーマット文字列＋引数
        sn(nil, {
          t("printf(\""), i(1, "format"), t("\", "), i(2, "args"), t(");"),
        }),
      }),
    }
  ),

  -- scanf スニペット: "scan"
  s(
    { trig = "scan", regTrig = false, wordTrig = true },
    {
      c(1, {
        -- 1つの変数を読み取る例
        sn(nil, {
          t("scanf(\""), i(1, "%d"), t("\", &"), i(2, "var"), t(");"),
        }),
        -- 複数の変数を読み取る例
        sn(nil, {
          t("scanf(\""), i(1, "%d %f"), t("\", &"), i(2, "i"), t(", &"), i(3, "f"), t(");"),
        }),
      }),
    }
  ),

  -- 変数宣言スニペット例: "var"
  -- 変数の型・名前・初期値を一気に入力可能
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      -- 型の候補
      c(1, {
        t("int"),
        t("char"),
        t("float"),
        t("double"),
        t("char *"),
        i(nil, "type"),
      }),
      t(" "),
      -- 変数名
      i(2, "name"),
      t(" = "),
      -- 初期値（デフォルトは 0）
      i(3, "0"),
      t(";"),
    }
  ),
}
