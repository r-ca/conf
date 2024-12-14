return {
  "tkmpypy/chowcho.nvim",
  config = function()
    require("chowcho").setup({})

    -- nvim-window-pickerの代替として動作させる
    package.loaded['window-picker'] = {
      pick_window = function()
        local selected_window_id
        require('chowcho').run(function(window_id)
          selected_window_id = window_id
        end)
        return selected_window_id
      end
    }
  end,
}
