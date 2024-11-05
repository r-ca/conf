function left-prompt {
    local name_t='254m%}'
    local arch_t='250m%}'
    local name_b='234m%}'
    local path_t='255m%}'
    local path_b='243m%}'
    local arrow='097m%}'
    local text_color='%{\e[38;5;'
    local back_color='%{\e[30;48;5;'
    local reset='%{\e[0m%}'
    local sharp='\uE0B0'
    local arch=`uname -m`

    user="${back_color}${name_b}${text_color}${name_t}"
    dir="${back_color}${path_b}${text_color}${path_t}"

    echo -e "${user}%n@%m ${text_color}${arch_t}(${arch})${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}-> ${reset}"
}
