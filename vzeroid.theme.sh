# scm theming
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${green}✓${normal}"
SCM_GIT_CHAR="${green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

scm_prompt() {
    CHAR=$(scm_char) 
    if [ $CHAR = $SCM_NONE_CHAR ] 
        then 
            return
        else 
            echo "[$(scm_char)$(scm_prompt_info)]"
    fi 
}

v_prompt() {
    ps_host="${bold_blue}\h${normal}";
    ps_user="${green}\u${normal}";
    ps_user_mark="${green} $ ${normal}";
    ps_path="${yellow}\w${normal}";
    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="]"
    KUBE_PS1_SYMBOL_ENABLE="false"

    PS1="\[$(clock_prompt)\] $(kube_ps1)$(scm_prompt):$ps_path$ps_user_mark"
}

safe_append_prompt_command v_prompt
