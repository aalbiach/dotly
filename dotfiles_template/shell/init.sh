#maxfiles="$(sysctl -a | grep kern.maxfiles: | awk '{print $2}')"
#maxfilesperproc="$(sysctl -a | grep kern.maxfilesperproc: | awk '{print $2}')"

# This is a useful file to have the same aliases/functions in bash and zsh
#ulimit -n "$maxfilesperproc" "$maxfiles"
#ulimit -u 2048

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Register custom aliases and functions
for aliasToSource in "$DOTFILES_PATH/shell/_aliases/"*; do source "$aliasToSource"; done
for exportToSource in "$DOTFILES_PATH/shell/_exports/"*; do source "$exportToSource"; done
for functionToSource in "$DOTFILES_PATH/shell/_functions/"*; do source "$functionToSource"; done
