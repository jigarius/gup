# gup

A simple bash function to help you "go up" from the current working directory.
This saves you the energy you'd otherwise spend on typing `cd` followed with a
bunch of `..` (dot dot).

## Installation

* Put the contents of this repository in a directory.
* Source the `gup.sh` file in your shell to get the `gup` command.

```
# In ~/.bashrc or equivalent.
source /path/to/gup/gup.sh
```

## Usage

Here are some ways to use `gup`.

```
# Goes up 1 level. Equivalent of cd ..
gup

# Goes up 3 levels. Equivalent of cd ../../..
gup 3
```

Feel free to use it and leave your suggestions!
