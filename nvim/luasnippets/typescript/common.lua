local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node

return {
  -- アロー関数スニペット: "fnar"
  s(
    { trig = "fnar", regTrig = false, wordTrig = false },
    -- 名前付きアロー or 無名アロー関数
    {
      c(1, {
        sn(nil, { t("const "), i(1, "name"), t(" = (") }),
        sn(nil, { t("(") }),
      }),
      i(3),   -- 引数
      t(") => {"),
      t({ "", "  " }),
      i(0),
      t({ "", "};" }),
    }
  ),

  -- 非同期関数定義スニペット: "fna:name" または "fna"
  s(
    { trig = "fna:?(.*)", regTrig = true, wordTrig = false },
    {
      t("async function "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "asyncFunctionName"))
        end
      end, {}),
      t("("),
      i(2, ""), -- 引数（デフォルトは空）
      t(")"),
      d(3, function()
        return sn(nil, {
          t(": Promise<"),
          i(1), -- 戻り値の型（デフォルトは空）
          t(">"),
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),

  -- 関数定義スニペット: "fn:name" または "fn"
  s(
    { trig = "fn:?(.*)", regTrig = true, wordTrig = false },
    {
      t("function "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "functionName"))
        end
      end, {}),
      t("("),
      i(2, ""), -- 引数（デフォルトは空）
      t(")"),
      d(3, function()
        return sn(nil, {
          t(": "),
          i(1), -- 戻り値の型（デフォルトは空）
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),

  -- クラス定義スニペット: "cl:name" または "cl"
  s(
    { trig = "cl:?(.*)", regTrig = true, wordTrig = false },
    {
      t("class "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "ClassName"))
        end
      end, {}),
      t(" {"),
      t({ "", "  constructor(" }),
      i(2, ""), -- コンストラクタ引数（デフォルトは空）
      t({ ") {", "    " }),
      i(0),     -- コンストラクタ本体
      t({ "", "  }", "", "}" }),
    }
  ),

  -- インターフェース定義スニペット: "inf:name" または "inf"
  s(
    { trig = "inf:?(.*)", regTrig = true, wordTrig = false },
    {
      t("interface "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "InterfaceName"))
        end
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- インターフェース本体
      t({ "", "}" }),
    }
  ),

  -- インポート文スニペット: "imp:module" または "imp"
  s(
    { trig = "imp:?(.*)", regTrig = true, wordTrig = false },
    {
      t("import "),
      c(1, {
        sn(nil, { t("{ "), i(1, "namedImport"), t(" }") }),
        sn(nil, { t("* as "), i(1, "alias") }),
        sn(nil, { i(1, "defaultImport") }),
      }),
      t(" from '"),
      d(2, function(args, parent)
        local module = parent.snippet.captures[1]
        if module and module ~= "" then
          return sn(nil, t(module))
        else
          return sn(nil, i(2, "module"))
        end
      end, {}),
      t("';"),
    }
  ),

  -- エクスポート文スニペット: "exp:name" または "exp"
  s(
    { trig = "exp:?(.*)", regTrig = true, wordTrig = false },
    {
      t("export "),
      c(1, {
        sn(nil, { t("default "), i(1, "defaultExport") }),
        sn(nil, { t("{ "), i(1, "namedExport"), t(" }") }),
        sn(nil, { i(1, "exportItem") }),
      }),
      t(";"),
    }
  ),

  -- 型エイリアススニペット: "alias:name" または "alias"
  s(
    { trig = "alias:?(.*)", regTrig = true, wordTrig = false },
    {
      t("type "),
      d(1, function(args, parent)
        local alias = parent.snippet.captures[1]
        if alias and alias ~= "" then
          return sn(nil, t(alias))
        else
          return sn(nil, i(1, "AliasName"))
        end
      end, {}),
      t(" = "),
      i(2, "TypeDefinition"),
      t(";"),
    }
  ),

  -- ジェネリック関数スニペット: "genfn:name" または "genfn"
  s(
    { trig = "genfn:?(.*)", regTrig = true, wordTrig = false },
    {
      t("function "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "genericFunction"))
        end
      end, {}),
      t("<"),
      i(2, "T"),
      t(">("),
      i(3, ""), -- 引数（デフォルトは空）
      t(")"),
      d(4, function()
        return sn(nil, {
          t(": "),
          i(1), -- 戻り値の型（デフォルトは空）
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),
}
