# map.fish

> Treat a paired array variable like a key/value map in Fish

The Fish shell lacks the concept of a key/value map. Sometimes referred to as an
"associative array", shells like [Zsh][zsh-assoc-arr] and [Bash][bash-assoc-arr] already
have this concept built in.

This Fish plugin gives you a simple `map` command, which lets you treat an array like
it is an associative array.

## Install

Use [Fisher][fisher] to install:

```fish
fisher install mattmc3/map.fish
```

## Usage

Use `--help` to show usage:

    > map --help
    map [-h|--help]
    map keys [MAPNAME]
    map values [MAPNAME]
    map get [MAPNAME] [KEY]
    map set [MAPNAME] [KEY] [VALUE]
    map remove [MAPNAME] [KEY]
    map contains [-k|--key] [-v|--value] [-i|--index] [MAPNAME] [STRING]

Let's demonstrate how to use a `map`. We start with a regular Fish array, the only
difference being that the elements of the array are paired
(eg: `key1 value1 key2 value2 etc..`). Let's declare an array called `fruits` with the
keys being types of fruit and the values containing the fruit's color.

    > set fruits banana yellow cherry red grape purple

To get an element from a map, use the `get` subcommand.

    > map get fruits grape
    purple

To set an element from a map, use the `set` subcommand.

    > map set fruits lime green
    > echo $fruits
    lime green banana yellow cherry red grape purple

To remove an element from a map, use the `remove` subcommand.

    > map remove fruits grape
    > echo $fruits
    lime green banana yellow cherry red

We can use the `keys` and `values` subcommands to see all the keys and values
respectively:

    > map keys fruits
    lime
    banana
    cherry
    > map values fruits
    green
    yellow
    red

Let's say we want to see if a key (or value) exists in the map. We can use the
`contains` subcommand. If the `--key` flag is provided, only keys are checked.
Similarly, if `--value` is provided, only values are checked. Otherwise both are. If
the `--index` flag is provided, then the index is printed.

    > map contains --key fruits cherry; and echo "found"; or echo "not found"
    found
    > map contains --value fruits orange; and echo "found"; or echo "not found"
    not found

If you want to use the original array, sometimes it's nice to use bracketed indexing.

    > set key_cherry (map contains -ki fruits cherry)
    > echo $fruits[$key_cherry]
    red


[fisher]: https://github.com/jorgebucaran/fisher
[bash-assoc-arr]: https://www.gnu.org/software/bash/manual/html_node/Arrays.html
[zsh-assoc-arr]: https://zsh.sourceforge.io/Doc/Release/Parameters.html#Array-Parameters
[zsh-param-exp]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags
