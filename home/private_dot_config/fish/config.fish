source ~/.config/fish/conf.d/env.fish
source ~/.config/fish/conf.d/paths.fish
source ~/.config/fish/conf.d/mise.fish
source ~/.config/fish/conf.d/aliases.fish

if test -z (pgrep ssh-agent | string collect)
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

set -g fish_greeting
