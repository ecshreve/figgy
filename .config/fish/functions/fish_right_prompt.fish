function fish_right_prompt
    set -l normal_color (set_color normal)
    set -l blue (set_color blue)

    echo -n $blue " $machine_user @ $machine_name " $normal_color
end
