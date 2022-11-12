# TODO: tweak this to match the left prompt
function fish_right_prompt
    set -l normal_color (set_color normal)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l orange (set_color yellow)
    set -l red (set_color red)
    set -l prompt_bk (set_color 3c3836)
    set -l bk_color (set_color --background 3c3836)


    set -l cmd_dur $CMD_DURATION
    set -l cur_time (date -u +%H:%M:%S:%z)

    if test $cmd_dur -gt 100
        set_color red
    else if test $cmd_dur -gt 10
        set_color yellow
    else
        set_color green
    end

    #  4 ms | 07:49:30:+0000 
    # echo -n " $cmd_dur ms | $cur_time " $normal_color
    echo -n ""$bk_color" $cmd_dur ms "
    echo -n $prompt_bk""$bk_color$blue "$machine_user@$machine_name "$normal_color$prompt_bk""

end
