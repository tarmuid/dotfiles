let data_home = ($env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share"))
if ($env.GOPATH? | is-empty) { $env.GOPATH = ($data_home | path join "go") }
if ($env.GOBIN? | is-empty) { $env.GOBIN = ($env.GOPATH | path join "bin") }

$env.PATH = ([$env.GOBIN] | append $env.PATH | flatten | uniq)
