function ls --wraps ls -d "list files with exa"
    if is-installed exa
        exa $argv --icons
    else
        command ls $argv
    end
end
