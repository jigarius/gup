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

  # By default, go up once.
  local TARGET="${1:-1}"
  __gup_log "Target is: $TARGET."

  # For numeric argument.
  if [[ $TARGET =~ ^-?[0-9]+$ ]]; then
    __gup_log "Target is numeric."
    __gup_by_number $TARGET
  fi
}

# Runs gup with numeric argument.
__gup_by_number() {
  # Cast argument to integer.
  local -i COUNT="${1:-1}"

  if (( $COUNT < 0 )); then
    __gup_log "Argument cannot be negative."
    exit 1
  fi

  local COMMAND=""
  if (( $COUNT == 0 )); then
    __gup_log "Staying in the same directory."

    COMMAND="cd ."
  else
    __gup_log "Going up $COUNT directories."

    local COMMAND="cd "
    for I in $(seq 1 $COUNT); do
      COMMAND="$COMMAND../"
    done
  fi

  __gup_log "Running: $COMMAND"
  eval $COMMAND
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
