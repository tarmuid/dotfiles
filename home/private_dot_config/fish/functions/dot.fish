function dot
    if test (count $argv) -eq 0
        echo "Usage: dot <subcommand> [options]"
        return 1
    end

    switch $argv[1]
        case daily
            run_daily_tasks $argv[2..-1]
        case '*'
            echo "Unknown subcommand '$argv[1]'"
            return 1
    end
end

function run_daily_tasks
    brew update
    brew upgrade
end
