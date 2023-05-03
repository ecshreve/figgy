# TODO: tweak this to match the left prompt
function fish_right_prompt
    set -l normal_color (set_color normal)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l yellow (set_color yellow)
    set -l red (set_color BD3F39)

    set -l prompt_bk (set_color 3c3836)
    set -l bk_color (set_color --background 3c3836)


    set -l cmd_dur $CMD_DURATION
    set -l cur_time (date -u +%H:%M:%S)

    if test $cmd_dur -gt 100
        echo -n $red
    else if test $cmd_dur -gt 10
        echo -n $yellow
    else
        echo -n $green
    end

    #  4 ms | 07:49:30:+0000 
    # echo -n " $cmd_dur ms | $cur_time " $normal_color
    echo -n ""$bk_color" $cmd_dur ms | $cur_time "
    echo -n $prompt_bk""$bk_color$blue "$(whoami)@$hostname "$normal_color$prompt_bk""

end
