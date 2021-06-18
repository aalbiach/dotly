#!/usr/bin/env bash

sdkman::update_all() {
  brew::self_update
  brew::update_candidates
}

sdkman::self_update() {
  sdk selfupdate 2>&1 | log::file "Updating SDKMAN"
}

sdkman::update_candidates() {
  sdk update 2>&1 | log::file "Updating SDKMAN candidates list"
  sdk upgrade 2>&1 | log::file "Upgrading SDKMAN candidates"
}
