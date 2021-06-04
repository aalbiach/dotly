# Uncomment for debug with `zprof`
# zmodload zsh/zprof

# ZSH Ops
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate entries from history
setopt HIST_FCNTL_LOCK
setopt +o nomatch
# setopt autopushd
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks from history items
setopt INC_APPEND_HISTORY   # save history entries as soon as they are entered
setopt SHARE_HISTORY        # share history between different instances of the shell
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt CORRECT_ALL          # autocorrect commands
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_MENU            # automatically use menu completion
setopt ALWAYS_TO_END        # move cursor to end if word had one match

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_THEME="spaceship"

# History config
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

source "$DOTFILES_PATH/shell/init.sh"

fpath=("$DOTFILES_PATH/shell/zsh/themes" "$DOTFILES_PATH/shell/zsh/autocompletions" "$DOTLY_PATH/shell/zsh/themes" "$DOTLY_PATH/shell/zsh/completions" $fpath)

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

source "$DOTLY_PATH/shell/zsh/bindings/dot.zsh"
source "$DOTLY_PATH/shell/zsh/bindings/reverse_search.zsh"
source "$DOTFILES_PATH/shell/zsh/key-bindings.zsh"


# Start Antibody
source <(antibody init)
antibody bundle < $DOTFILES_PATH/shell/zsh/.zsh_plugins

autoload -U promptinit && promptinit

source "$DOTFILES_PATH/shell/zsh/themes/$ZSH_THEME/conf.sh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
