let data_home = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
if ($env.CARGO_HOME? | is-empty) { $env.CARGO_HOME = ($data_home | path join "cargo") }
if ($env.RUSTUP_HOME? | is-empty) { $env.RUSTUP_HOME = ($data_home | path join "rustup") }

let cargo_bin = ($env.CARGO_HOME | path join "bin")
$env.PATH = ([$cargo_bin] | append $env.PATH | flatten | uniq)
