function g
    if test (count $argv) -eq 0
        hub status --short
    else
        hub $argv
    end
end
