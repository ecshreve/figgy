function system-type
    if test (uname) = Linux
        set --universal machine_sigil 
        if is-installed yum
            echo yum
            return
        else if is-installed apt-get
            echo apt
            return
        end
    else if test (uname) = Darwin
        set --universal machine_sigil 
        echo macos
        return
    end
    set --universal machine_sigil "?"
    echo unknown
end
