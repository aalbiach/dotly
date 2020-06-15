#!/bin/user/env bash

install_macos_custom() {
  # Install brew if not installed
  if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # All apps (This line is 2 times because there are dependencies between brew cask and brew)
  brew bundle --file="$DOTFILES_PATH/os/mac/brew/Brewfile" || true
  brew bundle --file="$DOTFILES_PATH/os/mac/brew/Brewfile"

  # Correct paths (so, we handle all with $PATH)
  # sudo truncate -s 0 /etc/paths

  # Custom macOS "defaults"
  sh "$DOTFILES_PATH/os/mac/mac-os.sh"

  # default is (257*1024)
  # sudo sysctl kern.maxvnodes=$((512*1024))
  # echo kern.maxvnodes=$((512*1024)) | sudo tee -a /etc/sysctl.conf

  # https://facebook.github.io/watchman/docs/install.html#mac-os-file-descriptor-limits
  # sudo sysctl -w kern.maxfiles=$((10*1024*1024))
  # sudo sysctl -w kern.maxfilesperproc=$((1024*1024))
  # echo kern.maxfiles=$((10*1024*1024)) | sudo tee -a /etc/sysctl.conf
  # echo kern.maxfilesperproc=$((1024*1024)) | sudo tee -a /etc/sysctl.conf
}

install_linux_custom() {
  echo
}
