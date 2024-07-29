function __map_complete_keys
    set --local tokens (commandline -opc)
    if test -n "$tokens[3]" && set -q $tokens[3]
        map keys $tokens[3] 2>/dev/null
    end
end

function __map_complete_fish_vars
    set -g | string replace ' ' \t"Global Variable: "
    set -l | string replace ' ' \t"Local Variable: "
    set -U | string replace ' ' \t"Universal Variable: "
    complete -c set -n '__fish_seen_argument -s e -l erase; and not __fish_seen_argument -s l -s U -s g -l local -l global -l Universal' -f -a "(set -U | string replace ' ' \tUniversal\ Variable:\ )"
end

complete -c map -x -s h -l help -d "Print help"
complete -c map -x -n __fish_use_subcommand -a keys --description "Get the keys from a map"
complete -c map -x -n __fish_use_subcommand -a values --description "Get the values from a map"
complete -c map -x -n __fish_use_subcommand -a set --description "Set a key/value pair in the map"
complete -c map -x -n __fish_use_subcommand -a get --description "Get the value associated with a key"
complete -c map -x -n __fish_use_subcommand -a index --description "Get the index of a value associated with a key"
complete -c map -f -n "__fish_is_nth_token 2" -a "(__map_complete_fish_vars)"
complete -c map -f -n "__fish_seen_subcommand_from get index set; and __fish_is_nth_token 3" -a "(__map_complete_keys)"
