K_PS1_ENABLED=off

kon() {
    K_PS1_ENABLED=on
    kubectl config current-context &> /dev/null
    if [[ $? -eq 1 ]]; then
        kubectl config set current-context `cat ~/.kubectl_current_context` &> /dev/null
    fi
}
koff() {
    K_PS1_ENABLED=off
    kubectl config current-context > ~/.kubectl_current_context
    kubectl config unset current-context &> /dev/null
}

k_prompt(){
    if [[ "${K_PS1_ENABLED}" == "on" ]]; then
        echo ' %{$fg[cyan]%}$(kubectl config current-context)%{$reset_color%}:%{$fg[green]%}$(kubectl config view --minify --output "jsonpath={..namespace}")%{$reset_color%}'
    fi
}
k_prompt_ctx(){
    if [[ "${K_PS1_ENABLED}" == "on" ]]; then
        echo " $(kubectl config current-context)"
    fi
}
k_prompt_ns(){
    if [[ "${K_PS1_ENABLED}" == "on" ]]; then
        echo "$(kubectl config view --minify --output 'jsonpath={..namespace}')"
    fi
}
k_prompt_separator(){
    if [[ "${K_PS1_ENABLED}" == "on" ]]; then
        echo ":"
    fi
}
PROMPT='%D{%H:%M:%S} %(!.%{$fg[red]%}.%{$fg[yellow]%})%~%{$reset_color%}%{$fg_bold[red]%}$(k_prompt_ctx)%{$reset_color%}$(k_prompt_separator)%{$fg_bold[cyan]%}$(k_prompt_ns)%{$reset_color%}$(git_prompt_info)%{$reset_color%} $ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
