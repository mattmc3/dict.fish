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
