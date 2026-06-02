# ============================================================
# .zshrc — zsh interactive shell config
# ============================================================

# Source shared shell config
[ -f "$HOME/.shell_common" ] && source "$HOME/.shell_common"

# ── Zsh-specific Options ────────────────────────────────────
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # push old directory onto stack
setopt PUSHD_IGNORE_DUPS    # no duplicate entries in stack
setopt CORRECT              # suggest corrections for typos
setopt COMPLETE_IN_WORD     # complete from both ends of a word
setopt ALWAYS_TO_END        # move cursor to end after completion
setopt EXTENDED_GLOB        # extended globbing
setopt NO_BEEP              # silence
setopt INTERACTIVE_COMMENTS # allow comments in interactive shell

# ── Zsh History ─────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS      # no duplicate adjacent entries
setopt HIST_IGNORE_ALL_DUPS  # remove older duplicate entries
setopt HIST_IGNORE_SPACE     # ignore commands starting with space
setopt HIST_FIND_NO_DUPS     # no duplicates in history search
setopt HIST_SAVE_NO_DUPS     # no duplicates in history file
setopt SHARE_HISTORY         # share history across sessions
setopt INC_APPEND_HISTORY    # append immediately

# ── Completion ──────────────────────────────────────────────
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%d%b'

# ── Prompt (pure-style fallback, no plugin required) ────────
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST
PROMPT='%B%F{green}%n@%m%f%b:%F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f %(?.%F{green}.%F{red})%#%f '

# ── Key Bindings ────────────────────────────────────────────
bindkey -e                          # emacs key bindings
bindkey '^[[A' history-search-backward  # up arrow: history search
bindkey '^[[B' history-search-forward   # down arrow: history search
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# ── Plugins (optional, loaded if present) ───────────────────
# zsh-syntax-highlighting
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── Local overrides ─────────────────────────────────────────
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
