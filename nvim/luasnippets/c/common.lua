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
        sn(nil, { t("<"), i(1, "stdio.h"), t(">") }),
        sn(nil, { t("\""), i(1, "header.h"), t("\"") }),
      }),
    }
  ),

  -- C の基本的な関数テンプレート: "func"
  -- choice_node の中身をすべて insert_node にして、初期値 "int" のまま Tab で次へ移動可能に
  s(
    { trig = "func", regTrig = false, wordTrig = true },
    {
      -- 戻り値型: デフォルトは "int"。Tab で次のノード（関数名）へ移動できる
      c(1, {
        i(nil, "int"),
        i(nil, "void"),
        i(nil, "char *"),
        i(nil, "type"),
      }),
      t(" "),
      -- 関数名
      i(2, "function_name"),
      t("("),
      -- 引数リスト
      i(3, "void"),
      t({ " {", "  " }),
      -- 本体
      i(0),
      t({ "", "}" }),
    }
  ),

  -- printf スニペット: "print"
  s(
    { trig = "print", regTrig = false, wordTrig = true },
    {
      c(1, {
        -- 引数なし版: printf("format");
        sn(nil, {
          t("printf(\""), i(1, "format"), t("\");"),
        }),
        -- 引数あり版: printf("format", args);
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
        -- 1 変数読み取り版: scanf("%d", &var);
        sn(nil, {
          t("scanf(\""), i(1, "%d"), t("\", &"), i(2, "var"), t(");"),
        }),
        -- 複数変数読み取り版: scanf("%d %f", &i, &f);
        sn(nil, {
          t("scanf(\""), i(1, "%d %f"), t("\", &"), i(2, "i"), t(", &"), i(3, "f"), t(");"),
        }),
      }),
    }
  ),

  -- 変数宣言スニペット: "var"
  -- スカラー or 配列 どちらも一つの choice_node で切り替え可能
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      -- ① 型の選択肢
      c(1, {
        i(nil, "int"),
        i(nil, "char"),
        i(nil, "float"),
        i(nil, "double"),
        i(nil, "char *"),
        i(nil, "type"),
      }),
      t(" "),
      -- ② 変数名
      i(2, "name"),
      t(" "),
      -- ③ スカラー or 配列 を選択
      c(3, {
        -- ③-1: スカラー (初期値付き)
        sn(nil, {
          t("= "), i(1, "0"), t(";"),
        }),
        -- ③-2: 配列 (サイズ指定)
        sn(nil, {
          t("["), i(1, "size"), t("]"), t(";"),
        }),
      }),
    }
  ),
}
