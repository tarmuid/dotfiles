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

if ($env.EDITOR? | is-empty) { $env.EDITOR = "vi" }
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
