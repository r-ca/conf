-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Workaround
vim.opt.termguicolors = true

-- Load plugins dir
require('lazy').setup({
  spec = {
    { import = "plugins" },
    { import = "lsp" },
    { import = "lsp.lang" },
    { import = "dap" },
    { import = "colors" }
  }
})

-- Load core
require('core.options')
require('core.others')
require('core.keymaps')

-- overseer
require("core.overseer")

require('testing.float')
require('testing.float-resize')
-- require('testing.split')
require('testing.smart-move-cursor')
-- require('testing.floating-menu.init')
