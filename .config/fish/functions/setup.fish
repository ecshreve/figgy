function setup
    log-line-colored "~~~ STARTING setup ~~~" blue

    # Check system type
    set system_type (system-type)
    if test $system_type = unknown
        echo "Unsupported OS"
        exit 1
    end

    log-line-colored "Setting up on $system_type" blue
    apt-mark showmanual
    log-line-colored "Done setting up on $system_type" blue
end
