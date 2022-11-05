function parser
    set -l package (with-default $_flag_name $_flag_apt)
    if test $package = SKIP
        return
    end
end
