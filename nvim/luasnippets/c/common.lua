local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local sn = ls.snippet_node

return {
  -- C の #include スニペット: トリガーを "incl"
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
  -- 戻り値型のデフォルトを int、ボディはスペース２インデント
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- 戻り値型（デフォルトは int）
      c(1, {
        t("int"),
        t("void"),
        t("char *"),
        i(nil, "type"), -- カスタム型を手入力したい場合
      }),
      t(" "),
      -- 関数名
      i(2, "function_name"),
      t("("),
      -- 引数リスト（デフォルトは void）
      i(3, "void"),
      t(")"),
      t({ " {", "  " }), -- 改行してスペース２文字インデント
      -- 関数本体
      i(0),
      t({ "", "}" }), -- 本体終了後に改行して閉じ括弧
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
        -- フォーマット＋引数
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
        -- 複数変数読み取りの例
        sn(nil, {
          t("scanf(\""), i(1, "%d %f"), t("\", &"), i(2, "i"), t(", &"), i(3, "f"), t(");"),
        }),
      }),
    }
  ),

  -- 変数宣言スニペット: "var"
  -- スカラー or 配列 を選択可能にし、スカラーは初期値付き、配列はサイズ指定
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
        -- ③-1: スカラー（初期値付き）
        sn(nil, {
          t("= "), i(1, "0"), t(";"),
        }),
        -- ③-2: 配列（サイズ指定）
        sn(nil, {
          t("["), i(1, "size"), t("]"), t(";"),
        }),
      }),
    }
  ),
}
