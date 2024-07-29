# Map - test completions

## Setup

    > source ./functions/map.fish
    > source ./completions/map.fish

## Test completions

Test that `map` describes itself:

    > complete -C map | column -t -s \t
    map  Treat a paired list like a map

Test that `map ` describes its subcommands:

    > complete -C 'map ' | column -t -s \t
    get     Get the value associated with a key
    index   Get the index of a value associated with a key
    keys    Get the keys from a map
    set     Set a key/value pair in the map
    values  Get the values from a map

Test that `map ` describes its subcommands:

    > complete -C 'map ' | column -t -s \t
    get     Get the value associated with a key
    index   Get the index of a value associated with a key
    keys    Get the keys from a map
    set     Set a key/value pair in the map
    values  Get the values from a map

Test that `map get fr` completes a variable:

    > set -gx fruits banana yellow cherry red grape purple
    > complete -C 'map get fr' | column -t -s \t
    fruits  Global Variable: 'banana'  'yellow'  'cherry'  'red'  'grape'  'purple'

Test that `map get fruits ` completes the keys in the `friuts` var:

    > complete -C 'map get fruits '
    banana
    cherry
    grape

Test that when `foo` isn't a real variable, `map get foo ` completes empty:

    > complete -C 'map get foo ' | column -t -s \t
    >
