return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    config = function()
        require('copilot').setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
            }
        })
    end
}
