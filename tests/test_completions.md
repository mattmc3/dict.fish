# Dict - test completions

## Setup

    > source ./functions/dict.fish
    > source ./completions/dict.fish

## Test completions

Test that `dict` describes itself:

    > complete -C dict | column -t -s \t
    dict  Treat a paired list like a dict

Test that `dict ` describes its subcommands:

    > complete -C 'dict ' | column -t -s \t
    get     Get the value associated with a key
    index   Get the index of a value associated with a key
    keys    Get the keys from a dict
    set     Set a key/value pair in the dict
    values  Get the values from a dict

Test that `dict ` describes its subcommands:

    > complete -C 'dict ' | column -t -s \t
    get     Get the value associated with a key
    index   Get the index of a value associated with a key
    keys    Get the keys from a dict
    set     Set a key/value pair in the dict
    values  Get the values from a dict

Test that `dict get fr` completes a variable:

    > set -gx fruits banana yellow cherry red grape purple
    > complete -C 'dict get fr' | column -t -s \t
    fruits  Global Variable: 'banana'  'yellow'  'cherry'  'red'  'grape'  'purple'

Test that `dict get fruits ` completes the keys in the `friuts` var:

    > complete -C 'dict get fruits '
    banana
    cherry
    grape

Test that when `foo` isn't a real variable, `dict get foo ` completes empty:

    > complete -C 'dict get foo ' | column -t -s \t
    >
