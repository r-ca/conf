return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
  },
  opts = {
  },
  config = function()
    require("CopilotChat").setup({
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN アクティブな選択範囲の説明を段落形式で書いてください。日本語で返答ください。",
        },
        Review = {
          prompt = "/COPILOT_REVIEW 選択されたコードをレビューしてください。日本語で返答ください。",
        },
        FixCode = {
          prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
        },
        Refactor = {
          prompt = "/COPILOT_GENERATE 明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。",
        },
        BetterNamings = {
          prompt = "/COPILOT_GENERATE 選択されたコードの変数名や関数名を改善してください。日本語で返答ください。",
        },
        Documentation = {
          prompt = "/COPILOT_GENERATE 選択範囲にドキュメントコメントを追加してください。日本語で返答ください。",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE コードのテストを生成してください。日本語で返答ください。",
        },
        Wording = {
          prompt = "/COPILOT_GENERATE 次のテキストの文法と表現を改善してください。日本語で返答ください。",
        },
        Summarize = {
          prompt = "/COPILOT_GENERATE 選択範囲の要約を書いてください。日本語で返答ください。",
        },
        Spelling = {
          prompt = "/COPILOT_GENERATE 次のテキストのスペルミスを修正してください。日本語で返答ください。",
        },
      }
    })
  end,
}
