-- Filename: python.lua
local ls = require("luasnip")
local s  = ls.snippet
local sn = ls.snippet_node
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local f  = ls.function_node -- 動的ノード用

return {
  -- 1. インポート スニペット: "imp" (Cの incl に対応)
  -- 一般的なモジュールのインポート方法を選択します。
  s(
    { trig = "import", regTrig = false, wordTrig = true },
    {
      c(1, {
        -- import module
        sn(nil, { t("import "), i(1, "module") }),
        -- from module import name
        sn(nil, { t("from "), i(1, "module"), t(" import "), i(2, "name") }),
        -- import module as alias
        sn(nil, { t("import "), i(1, "module"), t(" as "), i(2, "alias") }),
        -- from module import name as alias
        sn(nil, { t("from "), i(1, "module"), t(" import "), i(2, "name"), t(" as "), i(3, "alias") }),
      }),
    }
  ),

  -- 2. 関数定義テンプレート: "def" (Cの func に対応)
  -- 同期/非同期、引数、戻り値の型、Docstringの有無を選択します。
  s(
    { trig = "def", regTrig = false, wordTrig = true },
    {
      -- ① 戻り値型 (同期 def or 非同期 async def)
      c(1, {
        t("def"),
        t("async def"),
      }),
      t(" "),
      i(2, "function_name"), -- 関数名
      t("("),
      -- ② 引数の選択
      c(3, {
        sn(nil, { i(1, "") }), -- 引数なし or 自由入力
        t("self"),
        sn(nil, { t("self, "), i(1, "args") }),
        t("cls"),
        sn(nil, { t("cls, "), i(1, "args") }),
        t("*args, **kwargs"),
      }),
      t(")"),
      -- ③ 戻り値の型ヒント選択
      c(4, {
        t(""), -- 型ヒントなし
        sn(nil, { t(" -> "), i(1, "None") }),
        sn(nil, { t(" -> "), i(1, "int") }),
        sn(nil, { t(" -> "), i(1, "str") }),
        sn(nil, { t(" -> "), i(1, "ReturnType") }), -- 自由入力
      }),
      t(":"),
      -- ④ ボディ (Docstring or pass/TODO)
      c(5, {
        -- Docstringあり
        sn(nil, {
            t({"", '\t"""' }),
            -- Docstring (動的にi(2)の関数名を参照)
            i(1, "Docstring for"),
            t(" "),
            -- function_node (f) を使用して、i(2)の内容をここにコピーする
            f(function(args) return args[1] and args[1][1] or "" end, {2}),
            t({ '"""', "\t" }),
            i(0, "pass"),
        }),
        -- Docstringなし (TODO)
        sn(nil, { t({"", "\t"}), i(0, "# TODO: implement") }),
        -- Docstringなし (pass)
        sn(nil, { t({"", "\t"}), i(0, "pass") }),
      }),
    }
  ),

  -- 3. Print スニペット: "prt" (Cの print に対応)
  -- 様々なprint関数の使い方を選択します。トリガーはprintキーワードとの衝突を避けるためprtとしています。
  s(
    { trig = "print", regTrig = false, wordTrig = true },
    {
      c(1, {
        -- print(f"{var=}") (デバッグ用: Python 3.8+)
        sn(nil, { t("print(f\"{"), i(1, "variable"), t("=}\")") }),
        -- print(f"message {var}") (f-string)
        sn(nil, { t("print(f\""), i(1, "message"), t(" { "), i(2, "variable"), t(" }\")") }),
        -- print(var)
        sn(nil, { t("print("), i(1, "variable"), t(")") }),
        -- print("...") (標準文字列)
        sn(nil, { t("print("), i(1, '"message"'), t(")") }),
      }),
    }
  ),

  -- 4. 標準入力 スニペット: "inp" (Cの scan に対応)
  -- 標準入力の受け取り方と、型の変換方法を選択します。
  s(
    { trig = "input", regTrig = false, wordTrig = true },
    {
      i(1, "variable"),
      t(" = "),
      c(2, {
        -- 文字列として受け取る: input()
        sn(nil, { t("input("), i(1, "\"Prompt: \""), t(")") }),
        -- 整数に変換: int(input())
        sn(nil, { t("int(input("), i(1, ""), t("))") }),
        -- 浮動小数点数に変換: float(input())
        sn(nil, { t("float(input("), i(1, ""), t("))") }),
        -- 空白区切りの入力をリストとして受け取る (競プロ等)
        sn(nil, {
            t("list(map("),
            -- ネストされた選択肢で型を選ぶ
            c(1, {
                t("int"),
                t("str"),
                t("float"),
            }),
            t(", input().split()))")
        }),
      }),
    }
  ),

  -- 5. 変数代入スニペット: "var" (Cの var に対応)
  -- C言語版の構造（型選択、変数名、初期化スタイルの選択）をPythonの型ヒントと初期化で再現します。
  s(
    { trig = "var", regTrig = false, wordTrig = true },
    {
      -- ① 変数名
      i(1, "name"),

      -- ② 型ヒントの選択 (Cの型選択に対応)
      c(2, {
        -- 型ヒントなし
        t(""),
        -- 型ヒントあり (ネストされた選択肢)
        sn(nil, {
          t(": "),
          c(1, {
            t("int"),
            t("str"),
            t("float"),
            t("bool"),
            sn(nil, { t("list["), i(1, "int"), t("]") }),
            sn(nil, { t("dict["), i(1, "str"), t(", "), i(2, "Any"), t("]") }),
            sn(nil, { i(1, "Type") }), -- 任意入力
          }),
        }),
      }),
      t(" = "),
      -- ③ 初期化スタイルの選択 (Cのスカラー/配列選択に対応)
      c(3, {
        -- スカラー値: var = value
        sn(nil, { i(1, "value") }),
        t("None"),
        -- リスト初期化: var = [ values ]
        sn(nil, {
          t("["),
          i(1, "elements"),
          t("]"),
        }),
        -- 辞書初期化: var = { key: value }
        sn(nil, {
          t("{"),
          i(1, "key: value"),
          t("}"),
        }),
      }),
    }
  ),
}
