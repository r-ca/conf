return {
  filetypes = { 'sass', 'scss', 'vue' },
  settings = {
    somesass = {
      scss = {
        diagnostics = {
          lint = {
            -- ドキュメントには無いけど何故か使える？？
            -- https://code.visualstudio.com/docs/languages/css#_customizing-css-scss-and-less-settings
            unknownAtRules = "ignore",
          },
        },
      },
    },
  },
}
