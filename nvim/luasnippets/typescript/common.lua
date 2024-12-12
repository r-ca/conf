local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node

return {
  -- 関数定義スニペット: "tsfn:name" または "tsfn"
  s(
    { trig = "tsfn:?(.*)", regTrig = true, wordTrig = false },
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
      i(2, "args"), -- 引数（デフォルトは空）
      t(")"),
      d(3, function()
        return sn(nil, {
          t(": "),
          i(1, ""), -- 戻り値の型（デフォルトは空）
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),

  -- 非同期関数定義スニペット: "tsfnasync:name" または "tsfnasync"
  s(
    { trig = "tsfnasync:?(.*)", regTrig = true, wordTrig = false },
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
      i(2, "args"), -- 引数（デフォルトは空）
      t(")"),
      d(3, function()
        return sn(nil, {
          t(": Promise<"),
          i(1, ""), -- 戻り値の型（デフォルトは空）
          t(">"),
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),

  -- シンプルなアロー関数スニペット: "tsarrow:name" または "tsarrow"
  s(
    { trig = "tsarrow:?(.*)", regTrig = true, wordTrig = false },
    {
      t("const "),
      d(1, function(args, parent)
        local name = parent.snippet.captures[1]
        if name and name ~= "" then
          return sn(nil, t(name))
        else
          return sn(nil, i(1, "arrowFunctionName"))
        end
      end, {}),
      t(" = ("),
      i(2, "args"), -- 引数（デフォルトは空）
      t(") => {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "};" }),
    }
  ),

  -- クラス定義スニペット: "tsclass:name" または "tsclass"
  s(
    { trig = "tsclass:?(.*)", regTrig = true, wordTrig = false },
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
      i(2, "args"), -- コンストラクタ引数（デフォルトは空）
      t({ ") {", "    " }),
      i(0), -- コンストラクタ本体
      t({ "", "  }", "", "}" }),
    }
  ),

  -- インターフェース定義スニペット: "tsinterface:name" または "tsinterface"
  s(
    { trig = "tsinterface:?(.*)", regTrig = true, wordTrig = false },
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
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),

  -- インポート文スニペット: "tsimp:module" または "tsimp"
  s(
    { trig = "tsimp:?(.*)", regTrig = true, wordTrig = false },
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

  -- エクスポート文スニペット: "tsexp:name" または "tsexp"
  s(
    { trig = "tsexp:?(.*)", regTrig = true, wordTrig = false },
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

  -- 型エイリアススニペット: "tsalias:aliasName" または "tsalias"
  s(
    { trig = "tsalias:?(.*)", regTrig = true, wordTrig = false },
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

  -- ジェネリック関数スニペット: "tsgenfn:name" または "tsgenfn"
  s(
    { trig = "tsgenfn:?(.*)", regTrig = true, wordTrig = false },
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
      i(3, "args"), -- 引数（デフォルトは空）
      t(")"),
      d(4, function()
        return sn(nil, {
          t(": "),
          i(1, ""), -- 戻り値の型（デフォルトは空）
        })
      end, {}),
      t(" {"),
      t({ "", "  " }),
      i(0), -- 本体
      t({ "", "}" }),
    }
  ),
}
