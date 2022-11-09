function has-setup-option --argument-names name
    if ! set -q $name
        log-line-colored "No configuration set for: $name" orange
        return 1
    end

    eval "test \$$name = true"
end
