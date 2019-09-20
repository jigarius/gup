# GUP: Go-Up

[![Build Status](https://travis-ci.com/jigarius/gup.svg?branch=master)](https://travis-ci.com/jigarius/gup)

A simple bash function to help you "go up" from the current working directory.
This saves you the energy you'd otherwise spend on typing `cd` followed with a
bunch of `..` (dot dot). Laziness is the mother of invention.

## Installation

* Put the contents of this repository in a directory.
* Source the `gup.sh` file in your shell to get the `gup` command.

```
# In ~/.bashrc or equivalent.
source /path/to/gup/gup.sh
source /path/to/gup/gup-completion.sh
```

## Usage

Here are some ways to use `gup`.

### No arguments

Goes up `1` level. Equivalent of `cd ..`.

```bash
/a/b/c $ gup # Goes to: /a/b
```

### Numeric argument

Goes up `3` levels. Equivalent of `cd ../../..`.

```bash
/a/b/c/d $ gup 3 # Goes to: /a
```

### Alphanumeric argument

Goes up to the nearest directory named `b`. If no directory with such a name
is found, then you stay in the same directory.


```bash
/a/b/b/c/d $ gup b # Goes to: /a/b/b
```

## Thank you

This little program was written for having fun some with `bash`. However, it
turned out to be something useful which I regularly use. Feel free to use it
and leave your suggestions!

Brought to you by [Jigarius](https://jigarius.com/).
