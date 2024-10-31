function mkp
    for file in $argv
        set -l dir (dirname $file)
        if not test -d $dir
            mkdir -p $dir
        end
        touch $file
    end
end
