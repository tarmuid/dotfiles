let zoxide_init = ($env.HOME | path join ".zoxide.nu")

if (which zoxide | is-not-empty) {
  zoxide init nushell | save -f $zoxide_init
} else {
  "" | save -f $zoxide_init
}
