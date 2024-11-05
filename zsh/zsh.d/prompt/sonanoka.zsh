function left-prompt {
    local name_t='254m%}'
    local gray_t='250m%}'
    local name_b='176m%}'
    local path_t='252m%}'
    local path_b='140m%}'
    local arrow='097m%}'
    local text_color='%{\e[38;5;'
    local back_color='%{\e[30;48;5;'
    local reset='%{\e[0m%}'
    local sharp='\uE0B4'
    local arch=`uname -m`

    user="${back_color}${name_b}${text_color}${name_t}"
    dir="${back_color}${path_b}${text_color}${path_t}"

    local _user=""

    local _host=""

    echo -e "${user}$(prompt_uname "${text_color}${gray_t}(Git:" ")")${text_color}${name_t}@%m${text_color}${gray_t}(${arch})${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}⊂(ﾟヮﾟ)⊃ > ${reset}"
}
