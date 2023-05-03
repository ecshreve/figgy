function setup
    log-line-colored "~~~ STARTING setup ~~~" blue

    # Check system type
    set system_type (system-type)
    if test $system_type = unknown
        echo "Unsupported OS"
        exit 1
    end

    log-line-colored "Setting up fish on $system_type" blue
    
    if ! is-installed fisher
        log-line-colored "installing fisher" magenta
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
        fisher install patrickf1/fzf.fish
        fisher install jethrokuan/z
        fisher install gazorby/fish-abbreviation-tips
        fisher install wfxr/forgit
    end

    log-line-colored "updating fisher plugins" magenta
    fisher update

    log-line-colored "... done setting up fish plugins" green

    log-line-colored "Done setting up on $system_type" blue
end
