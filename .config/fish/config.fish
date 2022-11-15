if status is-interactive
    # Commands to run in interactive sessions can go here
    set fzf_fd_opts --hidden --no-ignore --exclude=.git
    fzf_configure_bindings --directory=\cff --git_log=\cfl --git_status=\cfs --processes=\cfp --variables=\cfv

end
