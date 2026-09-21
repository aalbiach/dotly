brew::install() {
	# Some aliases
	case "$1" in
	"docpars")
		# The tap only ships x86_64 binaries, so on Apple Silicon fail here
		# and let other package managers (cargo) build docpars from source
		platform::is_macos_arm && return 1
		package="denisidoro/tools/docpars"
		;;
	*) package="$1" ;;
	esac

	brew install "$package"
}
