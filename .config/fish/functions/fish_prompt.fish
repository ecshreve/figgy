function fish_prompt
    set -l last_command_status $status

    set -l normal_color (set_color normal)
    set -l white (set_color white)
    set -l prompt_bk (set_color 3c3836)

    set -l bold (set_color normal --bold)
    set -l cyan (set_color cyan)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l magenta (set_color magenta --bold)
    set -l blue (set_color blue)

    set -l fish "⋊>"

    set -l ahead $blue"↑"
    set -l behind $blue"↓"
    set -l diverged "⥄ "
    set -l dirty $red"o"
    set -l none $green"◦"

    if test -z "$machine_sigil"
        set machine_sigil "?"
    end

    echo -n $prompt_bk""
    set_color --background 3c3836
    echo -n $white" $machine_sigil "
    echo -n $white "〉"
    echo -n $cyan(prompt_pwd)" "

    if git_is_repo
        # git branch
        echo -n $white "〉"$green" "$white(git_branch_name)" "

        # git status
        if git_is_touched
            echo -n -s $dirty
        else
            echo -n -s (git_ahead $ahead $behind $diverged $none)
        end
        echo -n " "
    end

    # set -l caret ❯
    set -l caret ""
    # prompt
    if test $last_command_status -eq 0
        echo -n -s $normal_color $green"$caret"
    else
        echo -n -s $normal_color $red"$caret"
    end



    set_color $fish_color_cwd
    echo -n " "
end
