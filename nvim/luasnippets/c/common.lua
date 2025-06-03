local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local sn = ls.snippet_node

return {
  -- C の #include スニペット: トリガーを "incl" に変更
  s(
    { trig = "incl", regTrig = false, wordTrig = true },
    {
      t("#include "),
      c(1, {
        sn(nil, { t("<"), i(1, "stdio.h"), t(">") }),    -- <stdio.h>
        sn(nil, { t("\""), i(1, "header.h"), t("\"") }), -- "header.h"
      }),
    }
  ),

  -- C の基本的な関数テンプレート: "func"
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- 戻り値型（デフォルトは int）
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

  -- 変数宣言スニペット: "var"
  -- スカラー変数 or 配列変数 を Choice で切り替えられるように
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      -- ① 型の選択肢
      c(1, {
        t("int"),
        t("char"),
        t("float"),
        t("double"),
        t("char *"),
        i(nil, "type"),
      }),
      t(" "),
      -- ② 変数名
      i(2, "name"),
      t(" "),
      -- ③ スカラー or 配列 を選択
      c(3, {
        -- ③-1: スカラー（初期値あり／なしを選べるように）
        sn(nil, {
          t("= "), i(1, "0"), t(";"),
        }),
        -- ③-2: 配列（たとえばサイズ [1] などを入力）
        sn(nil, {
          t("["), i(1, "size"), t("]"), t(";"),
        }),
      }),
    }
  ),
}
