require("overseer").setup({
  templates = {
    "builtin",
    "user.lang.c.build_gcc",
    "user.lang.java.build_javac",
    "user.lang.python.run_python3",
  },
})
