debug-fish-init start (status -f)
if is-installed tmux
    if test -n "$TERM"; and status --is-login
        if test "$TERM" != screen; and test -z "$TMUX"
            exec tmux new-session -A -s main
        end
    end
end
debug-fish-init end (status -f)
