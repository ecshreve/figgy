function fish_prompt
    set -l last_command_status $status

    set -l normal_color (set_color normal)
    set -l bold (set_color normal --bold)

    set -l white (set_color white)
    set -l prompt_bk (set_color 3c3836)

    set -l cyan (set_color cyan)
    set -l red (set_color BD3F39)
    set -l green (set_color green)
    set -l magenta (set_color magenta --bold)
    set -l blue (set_color blue)
    set -l red (set_color yellow)

    set -l ahead $blue"↑"
    set -l behind $blue"↓"
    set -l diverged "⥄ "
    set -l dirty $red"⦿"
    set -l staged $red"⦿"
    set -l none $green"⦾"

    set -l system_type = system-type

    # Sigil, working directory, and git info on left prompt.
    echo -n $prompt_bk""
    set_color --background 3c3836
    echo -n $white" $machine_sigil "
    echo -n $white "〉"
    echo -n $cyan(prompt_pwd)" "

    if git_is_repo
        # git branch
        echo -n $white "〉"$green" "$white(git_branch_name)" "

        # git status
        if git_is_staged
            echo -n -s $staged
        else
            if git_is_touched
                echo -n -s $dirty
            else
                echo -n -s (git_ahead $ahead $behind $diverged $none)
            end
        end
        echo -n " "
    end

    set -l caret ""
    if test $last_command_status -eq 0
        echo -n -s $normal_color $green"$caret"
    else
        echo -n -s $normal_color $red"$caret"
    end

    set_color $fish_color_cwd
    echo -n " "
end
