# Nushell Environment Config File
#
# version = "0.99.1"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
	"PATH": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
	"Path": {
		from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
		to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
	}
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# *nix locale
$env.LC_ALL = "en_US.UTF-8"

if (sys host | get name) == "Darwin" {
    $env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
}

if (sys host | get name) == "Darwin" {
    $env.PATH = ($env.PATH | split row (char esep) | append "/usr/local/bin" )
}

$env.PATH = ($env.PATH | split row (char esep) | append $"($env.HOME)/.local/bin" )
