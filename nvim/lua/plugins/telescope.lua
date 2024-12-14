return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('telescope').setup {
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
      },
      extensions = {
        menu = {
          default = {
            items = {
              { "Copilot Chat", "Telescope menu copilot" },
            },
          },
          copilot = {
            items = {
              { "Open",           "CopilotChatOpen" },
              { "Close",          "CopilotChatClose" },
              { "Agents",         "CopilotChatAgents" },
              { "Better Namings", "CopilotChatBetterNamings" },
              { "Commit",         "CopilotChatCommit" },
              { "Commit Staged",  "CopilotChatCommitStaged" },
              { "Debug Info",     "CopilotChatDebugInfo" },
              { "Docs",           "CopilotChatDocs" },
              { "Documentation",  "CopilotChatDocumentation" },
              { "Explain",        "CopilotChatExplain" },
              { "Fix",            "CopilotChatFix" },
              { "Fix Code",       "CopilotChatFixCode" },
              { "Fix Diagnostic", "CopilotChatFixDiagnostic" },
              { "Load",           "CopilotChatLoad" },
              { "Models",         "CopilotChatModels" },
              { "Optimize",       "CopilotChatOptimize" },
              { "Refactor",       "CopilotChatRefactor" },
              { "Reset",          "CopilotChatReset" },
              { "Review",         "CopilotChatReview" },
              { "Save",           "CopilotChatSave" },
              { "Spelling",       "CopilotChatSpelling" },
              { "Stop",           "CopilotChatStop" },
              { "Summarize",      "CopilotChatSummarize" },
              { "Tests",          "CopilotChatTests" },
              { "Toggle",         "CopilotChatToggle" },
              { "Wording",        "CopilotChatWording" },
            }
          }
        },
      },
    }
  end
}
