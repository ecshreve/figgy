function log-line-colored --argument-names val col
    set_color $col
    echo $val
    set_color normal
end
