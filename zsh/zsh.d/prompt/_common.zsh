function prompt_uname() {
    local git_uname=`git config user.name`
    local current_uname=`print -P %n`

    if [ -n "$git_uname" ] && [ "$git_uname" != "$current_uname" ]; then
        if [ $# -eq 2 ]; then
            echo -e "${current_uname}${1}${git_uname}${2}"
        else # fallback
            echo -e "${current_uname}(git:${git_uname})"
        fi
    else
        echo -e "${current_uname}"
    fi
}

