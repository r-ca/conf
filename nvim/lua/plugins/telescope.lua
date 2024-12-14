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
              { "Open", "CopilotChatOpen" },
              { "Close", "CopilotChatClose" },
            }
          }
        },
      },
    }
  end
}
