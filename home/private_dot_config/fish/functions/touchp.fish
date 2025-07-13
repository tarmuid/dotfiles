function touchp --description "touch a file, creating any missing parent directories"
    if test (count $argv) -eq 0
        echo "Usage: touchp <path> [more paths …]" >&2
        return 1
    end

    for f in $argv
        # Resolve the directory part; ‘dirname’ never strips the leading slash (POSIX-consistent).
        set dir (dirname -- "$f")

        # Only create a directory when there is one to create (i.e., not “.” for bare filenames).
        if test "$dir" != "."
            mkdir -p -- "$dir"
        end

        touch -- "$f"
    end
end
