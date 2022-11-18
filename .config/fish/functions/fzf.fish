function fzf --wraps=fzf --description="Use fzf-tmux if in tmux session"
    if set --query TMUX
        fzf-tmux -p 84%,80% $argv
    else
        command fzf $argv
    end
end
