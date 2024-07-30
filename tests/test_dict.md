# Dict - test dict

## Setup

    > source ./functions/dict.fish
    > set fruits banana yellow cherry red grape purple

## Test keys subcommand

Test that `dict keys [DICTNAME]` shows keys:

    > dict keys fruits
    banana
    cherry
    grape

## Test empty

Start with an empty fruits array:

    > set fruits

Test that an empty array works for the `keys` subcommand:

    > dict keys fruits; echo $status
    0

Test that an empty array works for the `values` subcommand:

    > dict values fruits; echo $status
    0

Test that an empty array works for the `get` subcommand:

    > dict get fruits apple; echo $status
    1

Test that an empty array works for the `contains` subcommand:
    > dict contains fruits apple; echo $status
    1

Test that an empty array works for the `set` subcommand:

    > dict set fruits apple red
    > echo $status
    0
    > count $fruits
    2
    > set fruits
