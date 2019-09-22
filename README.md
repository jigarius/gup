# GUP: Go-Up

[![Build Status](https://travis-ci.com/jigarius/gup.svg?branch=master)](https://travis-ci.com/jigarius/gup)

A simple bash function to help you "go up" from the current working directory.
This saves you the energy you'd otherwise spend on typing `cd` followed with a
bunch of `..` (dot dot). Laziness is the mother of invention.

## Installation

* Put the contents of this repository in a directory.
* Source `gup.sh` file in your shell to get the `gup` command.
* Source `gup-completion.sh` file in your shell to get `tab` completion.

Run `gup --help` to see the man page.

```bash
# In ~/.bashrc or equivalent.
source /path/to/gup/gup.sh
source /path/to/gup/gup-completion.sh
```

## Usage

### Common usage

`gup` is intended to be used with a numeric or a string target (argument).

```bash
# Running "gup 3" is the equivalent of cd ../../..
/a/b/c/d $ gup 3 # Goes to: /a
# Running "gup b" takes you to the nearest directory in the current working
# path with the name "b".
/a/b/b/c/d $ gup b # Goes to: /a/b/b
```

For a given target, `gup` checks if an ancestor directory a matching
exists. If yes, then the user is taken there. If not, then it tries to treat
the argument as an integer and attempts to take the user \fTARGET\fP levels
above the current directory.

### Special cases

If the argument is numeric and an ancestor directory with a matching name
exists, then you go up to that ancestor directory. However, you can force the
argument to be treated as a number with the `--number` or `-n` flag.

```bash
/a/2/c/d/e $ gup 2 # Goes to: /a/2
/a/2/c/d/e $ gup -n 2 # Goes to: /a/2/c
```

### Interactive mode

If you don't know where you want to go, you can use the interactive mode
using the `--interactive` or `-i` flag.

```bash
/a/2/c/d/e $ gup -i
Choose a destination directory:
1) d
2) c
3) 2
4) a
```

### Help

Forgot your commands? Worry not! Run `gup --help` to see a man page.

## Thank you

This little program was written for having fun some with `bash`. However, it
turned out to be something useful which I regularly use. Feel free to use it
and leave your suggestions!

Brought to you by [Jigarius](https://jigarius.com/).
