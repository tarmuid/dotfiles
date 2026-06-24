def --env mkcd [dir: path] {
  mkdir $dir
  cd $dir
}

def --env path_prepend [dir: path] {
  if ($dir | path exists) {
    $env.PATH = ($env.PATH | prepend $dir | uniq)
  }
}
