let data_home = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
if ($env.BUN_INSTALL? | is-empty) { $env.BUN_INSTALL = ($data_home | path join "bun") }
if ($env.PNPM_HOME? | is-empty) { $env.PNPM_HOME = ($data_home | path join "pnpm") }

let bun_bin = ($env.BUN_INSTALL | path join "bin")
$env.PATH = ([$bun_bin $env.PNPM_HOME] | append $env.PATH | flatten | uniq)
