function fish_right_prompt
    set -l normal_color (set_color normal)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l orange (set_color yellow)
    set -l red (set_color red)


    set -l cmd_dur $CMD_DURATION
    set -l cur_time (date -u +%H:%M:%S:%z)

    if test $cmd_dur -gt 100
        echo -n $red
    else if test $cmd_dur -gt 10
        echo -n $orange
    else
        echo -n $green
    end

    echo -n " $cmd_dur ms | $cur_time " $normal_color
    echo -n $blue" $machine_user@$machine_name " $normal_color
end
