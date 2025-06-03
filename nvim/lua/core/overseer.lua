require("overseer").setup({
  templates = {
    "builtin",
    "user.lang.c.build_gcc",
    "user.lang.java.build_javac",
    "user.lang.python.run_python3",
  },
  task_list = {
    bindings = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-j>"] = false,
      ["<C-k>"] = false,
    }
  }
})
