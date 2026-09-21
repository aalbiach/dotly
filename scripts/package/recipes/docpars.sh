docpars::install() {
	# The denisidoro/tools tap only ships x86_64 binaries, which can't run on
	# Apple Silicon without Rosetta, so docpars is built from source there.
	if ! platform::is_macos_arm; then
		platform::command_exists brew && brew install denisidoro/tools/docpars && return 0 || true
	fi

	script::depends_on cargo

	export PATH="$HOME/.cargo/bin:$PATH"
	cargo install docpars
}

docpars::is_installed() {
	platform::command_exists docpars && docpars --version &>/dev/null
}
