$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local/bin") | uniq)

if ($env.XDG_CONFIG_HOME? | is-empty) { $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config") }
if ($env.XDG_CACHE_HOME? | is-empty) { $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache") }
if ($env.XDG_DATA_HOME? | is-empty) { $env.XDG_DATA_HOME = ($env.HOME | path join ".local/share") }
if ($env.XDG_STATE_HOME? | is-empty) { $env.XDG_STATE_HOME = ($env.HOME | path join ".local/state") }

if ($env.XDG_CONFIG_DIRS? | is-empty) {
  let dirs = (["/etc/xdg"]
    | prepend (if (($nu.os-info.name == "macos") and ("/opt/homebrew/etc/xdg" | path exists)) { "/opt/homebrew/etc/xdg" } else { null })
    | prepend (if (($nu.os-info.name == "macos") and ("/usr/local/etc/xdg" | path exists)) { "/usr/local/etc/xdg" } else { null })
    | compact)
  $env.XDG_CONFIG_DIRS = ($dirs | str join (char esep))
}

if ($env.XDG_DATA_DIRS? | is-empty) {
  let dirs = (["/usr/local/share" "/usr/share"]
    | prepend (if (($nu.os-info.name == "macos") and ("/opt/homebrew/share" | path exists)) { "/opt/homebrew/share" } else { null })
    | compact)
  $env.XDG_DATA_DIRS = ($dirs | str join (char esep))
}

if ($env.EDITOR? | is-empty) { $env.EDITOR = "nvim" }
if ($env.PAGER? | is-empty) { $env.PAGER = "less" }

$env.ENV_CONVERSIONS = ($env.ENV_CONVERSIONS | merge {
  XDG_CONFIG_DIRS: {
    from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
    to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
  }
  XDG_DATA_DIRS: {
    from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
    to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
  }
})

const config_dir = ($nu.env-path | path dirname)
const javascript_config = if (($config_dir | path join "config.d" "javascript.nu") | path exists) { ($config_dir | path join "config.d" "javascript.nu") } else { null }
const go_config = if (($config_dir | path join "config.d" "go.nu") | path exists) { ($config_dir | path join "config.d" "go.nu") } else { null }
const rust_config = if (($config_dir | path join "config.d" "rust.nu") | path exists) { ($config_dir | path join "config.d" "rust.nu") } else { null }
const zoxide_config = if (($config_dir | path join "config.d" "zoxide.nu") | path exists) { ($config_dir | path join "config.d" "zoxide.nu") } else { null }

source $javascript_config
source $go_config
source $rust_config
source $zoxide_config
