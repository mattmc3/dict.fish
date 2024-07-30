# dict.fish

> Treat a key/value paired array like a dictionary in Fish

The Fish shell lacks the concept of a key/value dictionary. Sometimes referred to as an
"associative array", shells like [Zsh][zsh-assoc-arr] and [Bash][bash-assoc-arr] already
have this concept built in.

There's an [open issue](https://github.com/fish-shell/fish-shell/issues/390) to add this
feature, but it's been 12 years and counting...

This Fish plugin gives you a simple `dict` command, which lets you treat an array like
it is an associative array.

## Install

Use [Fisher][fisher] to install:

```fish
fisher install mattmc3/dict.fish
```

## Usage

Use `--help` to show usage:

    > dict --help
    dict [-h|--help]
    dict keys [DICTNAME]
    dict values [DICTNAME]
    dict get [DICTNAME] [KEY]
    dict set [DICTNAME] [KEY] [VALUE]
    dict remove [DICTNAME] [KEY]
    dict contains [-k|--key] [-v|--value] [-i|--index] [DICTNAME] [STRING]

Let's demonstrate how to use a `dict`. We start with a regular Fish array, the only
difference being that the elements of the array are paired
(eg: `key1 value1 key2 value2 etc..`). Let's declare an array called `fruits` with the
keys being types of fruit and the values containing the fruit's color.

    > set fruits banana yellow cherry red grape purple

To get an element from a dictionary, use the `get` subcommand.

    > dict get fruits grape
    purple

To set an element from a dictionary, use the `set` subcommand.

    > dict set fruits lime green
    > echo $fruits
    lime green banana yellow cherry red grape purple

To remove an element from a dictionary, use the `remove` subcommand.

    > dict remove fruits grape
    > echo $fruits
    lime green banana yellow cherry red

We can use the `keys` and `values` subcommands to see all the keys and values
respectively:

    > dict keys fruits
    lime
    banana
    cherry
    > dict values fruits
    green
    yellow
    red

Let's say we want to see if a key (or value) exists in the dictionary. We can use the
`contains` subcommand. If the `--key` flag is provided, only keys are checked.
Similarly, if `--value` is provided, only values are checked. Otherwise both are. If
the `--index` flag is provided, then the index is printed.

    > dict contains --key fruits cherry; and echo "found"; or echo "not found"
    found
    > dict contains --value fruits orange; and echo "found"; or echo "not found"
    not found

If you want to use the original array, sometimes it's nice to use bracketed indexing.

    > set key_cherry (dict contains -ki fruits cherry)
    > echo $fruits[$key_cherry]
    red


[fisher]: https://github.com/jorgebucaran/fisher
[bash-assoc-arr]: https://www.gnu.org/software/bash/manual/html_node/Arrays.html
[zsh-assoc-arr]: https://zsh.sourceforge.io/Doc/Release/Parameters.html#Array-Parameters
[zsh-param-exp]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags
