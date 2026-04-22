local vue_ts_plugin = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

return {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_ts_plugin,
        languages = { "javascript", "typescript", "vue" },
        configNamespace = 'typescript'
      },
    },
  },
  filetypes = {
    "javascript", "typescript", "vue", "typescriptreact", "javascriptreact", "typescript.tsx", "javascript.jsx"
  },
}
