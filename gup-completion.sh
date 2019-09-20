#!/usr/bin/env bash

# bash completion for Go-Up (gup).

if ! command -v gup &> /dev/null; then
  return
fi

# Gup command-completion with TAB.
__gup_complete() {
  # Ignore the current directory from suggestions.
  local SUGG_PATH=$(dirname $PWD)
  while [ "$SUGG_PATH" != "/" ]
  do
    # SUGG_DIRNAME=$(basename "$SUGG_PATH")
    # COMPREPLY+=$("$SUGG_DIRNAME")
    COMPREPLY+=($(basename "$SUGG_PATH"))
    SUGG_PATH=$(dirname $SUGG_PATH)
  done
}

# "complete" is a bash builtin. However, recent versions of ZSH come with a
# function called "bashcompinit" that will create a complete in ZSH.
# If the user is in ZSH, run "bashcompinit" before calling "complete".
#
# This IF statement below was taken from NVM.
# See https://github.com/nvm-sh/nvm/blob/master/bash_completion
if [[ -n ${ZSH_VERSION-} ]]; then
  autoload -U +X bashcompinit && bashcompinit
  autoload -U +X compinit && if [[ ${ZSH_DISABLE_COMPFIX-} = true ]]; then
    compinit -u
  else
    compinit
  fi
fi

complete -F __gup_complete gup
