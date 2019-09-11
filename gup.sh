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
  local -i COUNT="${1:-1}"
  __gup_log "Target is: $COUNT"

  # Build command.
  local COMMAND=""

  # For numeric argument.
  COMMAND="cd "
  for i in $(seq 1 $COUNT); do
    COMMAND="$COMMAND../"
  done

  # Execute command.
  if [[ ! -z "$COMMAND" ]]; then
    __gup_log "Running command: $COMMAND"
    eval $COMMAND
  else
    __gup_log "Error: Nothing can be done."
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
