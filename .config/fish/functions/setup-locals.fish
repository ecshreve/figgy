function setup-locals
    if test -f ~/locals.fish
        source ~/locals.fish
    else
        touch ~/locals.fish
    end

    set overrides 0
    for line in (cat ~/locals.fish.example)
        if string match -rq 'set (?<scope>[A-z-]+) (?<name>[A-z_]+) (?<default>.*)' "$line"
            if test -z "$name"
                echo "Failed to parse line: $line"
                return 1
            end

            if set -q $name
                continue
            end

            set default_value (eval echo $default)
            read --prompt='set_color green; echo -n "$name? [$default_value] "; set_color normal;' response
            if test -z "$response"
                echo "set $scope $name $default_value" >>~/locals.fish
            else
                echo "set $scope $name $response" >>~/locals.fish
                set overrides (math $overrides+1)
            end
        end
    end

    log-line-colored "writing $overrides overrides to locals.fish..." purple
    source ~/locals.fish
end
