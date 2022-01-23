# scm theming
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${green}✓${normal}"
SCM_GIT_CHAR=" ${green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

scm_prompt() {
    CHAR=$(scm_char) 
    if [ $CHAR = $SCM_NONE_CHAR ] 
        then 
            return
        else 
            echo "$(scm_char)$(scm_prompt_info)"
    fi 
}

K_PS1_ENABLED=off

kon() {
    K_PS1_ENABLED=on
}
koff() {
    K_PS1_ENABLED=off
}

k_prompt(){
    if [[ "${K_PS1_ENABLED}" == "on" ]]; then
        echo " ${bold_red}$(kubectl config current-context)${normal}:${bold_cyan}$(kubectl config view --minify --output 'jsonpath={..namespace}')${normal} "
    fi
}

v_prompt() {
    ps_host="${bold_blue}\h${normal}";
    ps_user="${green}\u${normal}";
    ps_user_mark="${green} $ ${normal}";
    ps_path="${yellow}\w${normal}";

    PS1="$(clock_prompt)$(k_prompt)$(scm_prompt):$ps_path$ps_user_mark"
}

safe_append_prompt_command v_prompt
