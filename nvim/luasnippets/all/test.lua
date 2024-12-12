local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s({
      trig = "hosi(.*)",
      regTrig = true,
    },
    fmt([[
        ひとり漕いでる
        {}はずっと
        ずっと軽くなってて。
        どこへ向かおうか{}
    ]], {
      f(function(_, snip) return snip.captures[1] end, {}),
      i(0),
    })
  )
}
