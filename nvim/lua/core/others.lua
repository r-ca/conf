-- Others
vim.api.nvim_create_user_command('PackageInfo',
    function(opts)
        require('package-info').show({ force = true })
    end, {
        nargs = 0
    }
)
