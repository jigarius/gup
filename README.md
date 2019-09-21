# GUP: Go-Up

[![Build Status](https://travis-ci.com/jigarius/gup.svg?branch=master)](https://travis-ci.com/jigarius/gup)

A simple bash function to help you "go up" from the current working directory.
This saves you the energy you'd otherwise spend on typing `cd` followed with a
bunch of `..` (dot dot). Laziness is the mother of invention.

## Installation

* Put the contents of this repository in a directory.
* Source `gup.sh` file in your shell to get the `gup` command.
* Source `gup-completion.sh` file in your shell to get `tab` completion.

```
# In ~/.bashrc or equivalent.
source /path/to/gup/gup.sh
source /path/to/gup/gup-completion.sh
```

## Usage

Run with no arguments to go up 1 directory.

```bash
# Equivalent of cd ..
/a/b/c $ gup # Goes to: /a/b
```

Run with a numeric argument to go up N directories.

```bash
# Equivalent of cd ../../..
/a/b/c/d $ gup 3 # Goes to: /a
```

Run with a string argument to go up to the nearest ancestor directory
with a matching name.

```bash
/a/b/b/c/d $ gup b # Goes to: /a/b/b
```

If the argument is numeric and an ancestor directory with a matching name
exists, then you go up to that ancestor directory.

```bash
/a/2/c/d/e $ gup 2 # Goes to: /a/2
```

## Thank you

This little program was written for having fun some with `bash`. However, it
turned out to be something useful which I regularly use. Feel free to use it
and leave your suggestions!

Brought to you by [Jigarius](https://jigarius.com/).
