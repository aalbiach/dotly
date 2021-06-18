source "$DOTLY_PATH/scripts/core/platform.sh"

if platform::is_macos; then
  HOMEBREW_DUMP_FILE_PATH="$DOTFILES_PATH/os/mac/brew/Brewfile"
elif platform::is_linux; then
  HOMEBREW_DUMP_FILE_PATH="$DOTFILES_PATH/os/linux/brew/Brewfile"
fi

APT_DUMP_FILE_PATH="$DOTFILES_PATH/os/linux/apt/packages.txt"
SNAP_DUMP_FILE_PATH="$DOTFILES_PATH/os/linux/snap/packages.txt"
PYTHON_DUMP_FILE_PATH="$DOTFILES_PATH/langs/python/requirements.txt"
NPM_DUMP_FILE_PATH="$DOTFILES_PATH/langs/js/global_modules.txt"
VOLTA_DUMP_FILE_PATH="$DOTFILES_PATH/langs/js/volta_dependencies.txt"
SDKMAN_DUMP_FILE_PATH="$DOTFILES_PATH/os/mac/sdk/candidates.txt"

package::brew_dump() {
  if platform::is_macos; then
    mkdir -p "$DOTFILES_PATH/os/mac/brew"
  else
    mkdir -p "$DOTFILES_PATH/os/linux/brew"
  fi

  brew bundle dump --file="$HOMEBREW_DUMP_FILE_PATH" --force
  brew bundle --file="$HOMEBREW_DUMP_FILE_PATH" --force cleanup
}

package::brew_import() {
  if [ -f "$HOMEBREW_DUMP_FILE_PATH" ]; then
    brew bundle install --file="$HOMEBREW_DUMP_FILE_PATH"
  fi
}

package::apt_dump() {
  mkdir -p "$DOTFILES_PATH/os/linux/apt"

  apt-mark showmanual >"$APT_DUMP_FILE_PATH"
}

package::apt_import() {
  if [ -f "$APT_DUMP_FILE_PATH" ]; then
    xargs sudo apt-get install -y <"$APT_DUMP_FILE_PATH"
  fi
}

package::snap_dump() {
  mkdir -p "$DOTFILES_PATH/os/linux/snap"

  snap list | tail -n +2 | awk '{ print $1 }' >"$SNAP_DUMP_FILE_PATH"
}

package::snap_import() {
  if [ -f "$SNAP_DUMP_FILE_PATH" ]; then
    xargs -I_ sudo snap install "_" <"$SNAP_DUMP_FILE_PATH"
  fi
}

package::python_dump() {
  mkdir -p "$DOTFILES_PATH/langs/python"

  pip3 freeze >"$PYTHON_DUMP_FILE_PATH"
}

package::python_import() {
  if [ -f "$PYTHON_DUMP_FILE_PATH" ]; then
    pip3 install -r "$PYTHON_DUMP_FILE_PATH"
  fi
}

package::npm_dump() {
  mkdir -p "$DOTFILES_PATH/langs/js"

  ls -1 /usr/local/lib/node_modules | grep -v npm >"$NPM_DUMP_FILE_PATH"
}

package::npm_import() {
  if [ -f "$NPM_DUMP_FILE_PATH" ]; then
    xargs -I_ npm install -g "_" <"$NPM_DUMP_FILE_PATH"
  fi
}

package::volta_dump() {
  mkdir -p "$DOTFILES_PATH/langs/js"

  volta list all --format plain | awk '{print $2}' >"$VOLTA_DUMP_FILE_PATH"
}

package::volta_import() {
  if [ -f "$VOLTA_DUMP_FILE_PATH" ]; then
    xargs -I_ volta install "_" <"$VOLTA_DUMP_FILE_PATH"
  fi
}

package::sdkman_dump() {
  mkdir -p "$DOTFILES_PATH/os/mac/sdk"

  mapfile -t candidates < <(__sdkman_build_version_csv | tr "," "\n")

  for candidate in ${candidates[*]}; do
    mapfile -t versions < <(__sdkman_build_version_csv "$candidate" | tr "," "\n")

    for version in ${versions[*]}; do
      echo "$candidate" "$version" >>"$SDKMAN_DUMP_FILE_PATH"
    done;

  done;
}

package::sdkman_import() {
  if [ -f "$SDKMAN_DUMP_FILE_PATH" ]; then
    xargs -I_ echo "sdk install _" <"$SDKMAN_DUMP_FILE_PATH"
  fi
}
