function __map_usage
    echo "map [-h|--help]"
    echo "map keys [MAPNAME]"
    echo "map values [MAPNAME]"
    echo "map get [MAPNAME] [KEY]"
    echo "map set [MAPNAME] [KEY] [VALUE]"
    echo "map remove [MAPNAME] [KEY]"
    echo "map contains [-k|--key] [-v|--value] [-i|--index] [MAPNAME] [STRING]"
end

function __map_check_mapname -a mapname
    # Check to see that the MAPNAME provided is a valid variable.
    if not set -q -- $mapname
        echo >&2 "map: Bad MAPNAME. Variable not found: '$mapname'."
        return 2
    end
end

function __map_contains --no-scope-shadowing
    argparse --name map --stop-nonopt -exclusive k,v 'k/key' 'v/value' 'i/index' -- $argv
    or return
    set --local -- mapname $argv[1]
    __map_check_mapname $mapname; or return $status
    set --local -- themap $$mapname

    set --local str $argv[2]
    set --local start 1
    set --local step 1
    set --local found 0
    if set -q _flag_value
        set start 2
    end
    if set -q _flag_key || set -q _flag_value
        set step 2
    end

    # echo "mapname: $mapname"
    # echo "start: $start"
    # echo "step: $step"
    # echo "count:" (count $themap)
    # echo "_flag_key: $_flag_key"
    # echo "_flag_value: $_flag_value"
    # echo "_flag_index: $_flag_index"

    for idx in (seq $start $step (count $themap))
        if test $themap[$idx] = "$str"
            if set -q _flag_index
                if set -q _flag_value
                    echo $idx
                else
                    math $idx + 1
                end
            end
            set found 1
        end
    end
    test $found -gt 0; and return 0; or return 1
end

function map \
    --description "Treat a paired list like a map" \
    --no-scope-shadowing

    argparse --name map --ignore-unknown --stop-nonopt 'h/help' -- $argv
    if set -q _flag_help
        __map_usage && return 0
    else if test (count $argv) -eq 0
        __map_usage && return 1
    end

    set --local subcommand $argv[1]
    set argv $argv[2..]

    # The 'contains' subcommand is more involved so skip it, but for the others we can
    # do this prep logic here.
    set --local themap
    set --local mapname
    set --local idx

    if test $subcommand != contains
        set -- mapname $argv[1]
        set -- themap $$mapname
        __map_check_mapname $mapname; or return $status
    end

    switch $subcommand
        case keys
            for idx in (seq 1 2 (count $themap))
                echo $themap[$idx]
            end
        case values
            for idx in (seq 2 2 (count $themap))
                echo $themap[$idx]
            end
        case get
            set --local key $argv[2]
            for idx in (seq 1 2 (count $themap))
                if test $themap[$idx] = "$key"
                    echo $themap[(math $idx + 1)]
                    return 0
                end
            end
            return 1
        case set
            set --local key $argv[2]
            set --local value "$argv[3..]"
            set --local mapsize (count $themap)
            for idx in (seq 1 2 $mapsize)
                if test $themap[$idx] = "$key"
                    if test $idx -eq 1
                        set $mapname $key $value $themap[3..]
                    else
                        set $mapname $themap[1..(math $idx - 1)] $key $value $themap[(math $idx + 2)..]
                    end
                    return 0
                end
            end
            set $mapname $key $value $themap
        case remove
            set --local key $argv[2]
            for idx in (seq 1 2 (count $themap))
                if test $themap[$idx] = "$key"
                    if test $idx -eq 1
                        set $mapname $themap[3..]
                    else
                        set $mapname $themap[1..(math $idx - 1)] $themap[(math $idx + 2)..]
                    end
                    return 0
                end
            end
            return 1
        case contains
            __map_contains $argv
            return $status
        case '*'
            echo >&2 "map: Subcommand not found '$subcommand'."
            return 2
    end
end
