return {
  'mfussenegger/nvim-dap-python',
  config = function()
    require('dap-python').setup('/home/rca/venv/python/debugpy/bin/python')
  end,
}
