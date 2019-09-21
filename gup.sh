# Gup entry-point.
gup() {
  # Get all arguments.
  local ARGS=( "$@" )

  # Check if verbose mode is enabled.
  __GUP_VERBOSE=false
  if [[ " ${ARGS[*]} " == *" -v "* ]]; then
    __GUP_VERBOSE=true
    __gup_log "Being verbose!"
  fi

  # Get the current working directory.
  local PWD_OLD="$PWD"
  __gup_log "Old PWD: $PWD"

  # By default, go up once.
  local TARGET="${1:-1}"
  __gup_log "Target is: $TARGET."

  # Treat target as a string first.
  # This looks up ancestor directories with numeric names, if any.
  __gup_log "Treating target as a string."
  __gup_by_string $TARGET

  # If treating the argument as a string doesn't have any effect,
  # then treat the argument as a number.
  if [[ "$PWD_OLD" == "$PWD" ]]; then
    __gup_log "Treating target as a number."
    __gup_by_number $TARGET
  fi

  __gup_log "New PWD: $PWD"
}

# Runs gup with numeric argument.
__gup_by_number() {
  # Cast argument to integer.
  local -i COUNT="${1:-1}"

  if (( $COUNT < 0 )); then
    __gup_log "Argument cannot be negative."
    return 1
  fi

  # If target is a string it will result in 0.  Alternatively, the user
  # might've entered "0" as the target. When argument is 0, we do nothing.
  if (( $COUNT != 0 )); then
    __gup_log "Going up $COUNT directories."

    local command="cd "
    for I in $(seq 1 $COUNT); do
      command="$command../"
    done

    __gup_eval "$command"
  fi
}

# Runs gup with string argument.
__gup_by_string() {
  local TARGET="$1"
  local DEST=$(dirname $PWD)
  local CURDIR=""

  # Look for the nearest parent directory named "$TARGET".
  while [ "$DEST" != "/" ]
  do
    CURDIR=$(basename $DEST)
    if [[ "$CURDIR" == "$TARGET" ]]; then
      __gup_log "Ancestor directory \"$TARGET\" found."
      break
    else
      __gup_log "Moving up: \"$CURDIR\" != \"$TARGET\""
    fi
    DEST=$(dirname $DEST)
  done

  # If a matching directory was found, go to it. However,
  # if a match was not found, we should be at "/" right now.
  if [[ "$DEST" == "/" ]]; then
    __gup_log "Ancestor directory \"$TARGET\" not found."
  else
    __gup_eval "cd $DEST"
  fi
}

# Executs a command.
#
# Usage: __gup_eval [command]
__gup_eval() {
  local command="$1"
  if [[ ! -z "$command" ]]; then
    __gup_log "Running: $command"
    eval $command
  fi
}

# Logs a message.
#
# Usage: __gup_log $MESSAGE
__gup_log() {
  local MESSAGE=$1
  if [ "$__GUP_VERBOSE" = true ]; then
    echo "$MESSAGE"
  fi
}
