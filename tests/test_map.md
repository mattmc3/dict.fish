# Map - test map

## Setup

    > source ./functions/map.fish
    > set fruits banana yellow cherry red grape purple

## Test keys subcommand

Test that `map keys [MAPNAME]` shows keys:

    > map keys fruits
    banana
    cherry
    grape

## Test empty

Start with an empty fruits array:

    > set fruits

Test that an empty array works for the `keys` subcommand:

    > map keys fruits; echo $status
    0

Test that an empty array works for the `values` subcommand:

    > map values fruits; echo $status
    0

Test that an empty array works for the `get` subcommand:

    > map get fruits apple; echo $status
    1

Test that an empty array works for the `contains` subcommand:
    > map contains fruits apple; echo $status
    1

Test that an empty array works for the `set` subcommand:

    > map set fruits apple red
    > echo $status
    0
    > count $fruits
    2
    > set fruits
