# ============================================================
# .bashrc — bash interactive shell config
# ============================================================

# Source shared shell config
[ -f "$HOME/.shell_common" ] && source "$HOME/.shell_common"

# ── Bash-specific Options ───────────────────────────────────
shopt -s histappend        # append to history instead of overwriting
shopt -s checkwinsize      # update LINES/COLUMNS after each command
shopt -s cdspell           # autocorrect minor cd typos
shopt -s autocd 2>/dev/null # type directory name to cd (bash 4+)
shopt -s globstar 2>/dev/null # enable **  globbing (bash 4+)

# ── Bash History ────────────────────────────────────────────
HISTFILE="$HOME/.bash_history"
# Sync history across sessions
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ── Prompt ──────────────────────────────────────────────────
_bash_prompt() {
    local reset='\[\e[0m\]'
    local bold='\[\e[1m\]'
    local green='\[\e[32m\]'
    local blue='\[\e[34m\]'
    local yellow='\[\e[33m\]'
    local red='\[\e[31m\]'

    # Show exit code of last command
    local exit_code=$?
    local status_color
    [ $exit_code -eq 0 ] && status_color=$green || status_color=$red

    # Git branch
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    local git_part
    [ -n "$branch" ] && git_part=" ${yellow}(${branch})${reset}" || git_part=''

    PS1="${bold}${green}\u@\h${reset}:${blue}\w${reset}${git_part} ${status_color}\$${reset} "
}
export PROMPT_COMMAND="_bash_prompt; $PROMPT_COMMAND"

# ── Bash Completion ─────────────────────────────────────────
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ── Local overrides ─────────────────────────────────────────
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
