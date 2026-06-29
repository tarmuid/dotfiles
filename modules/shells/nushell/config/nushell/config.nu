const config_dir = ($nu.config-path | path dirname)

source ($config_dir | path join "options.nu")
source ($config_dir | path join "functions.nu")
source ($config_dir | path join "aliases.nu")
source ~/.zoxide.nu
