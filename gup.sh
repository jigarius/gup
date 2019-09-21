# Gup entry-point.
gup() {
  # Get all arguments.
  local args=( "$@" )

  # Check if verbose mode is enabled.
  __GUP_VERBOSE=false
  if [[ " ${args[*]} " == *" -v "* ]]; then
    __GUP_VERBOSE=true
    __gup_log "Being verbose!"
  fi

  # Get the current working directory.
  local pwd_old="$PWD"
  __gup_log "Old PWD: $pwd_old"

  # By default, go up once.
  local target="${1:-1}"
  __gup_log "Target is: $target."

  # Treat target as a string first.
  # This looks up ancestor directories with numeric names, if any.
  __gup_log "Treating target as a string."
  __gup_by_string $target

  # If treating the argument as a string doesn't have any effect,
  # then treat the argument as a number.
  if [[ "$pwd_old" == "$PWD" ]]; then
    __gup_log "Treating target as a number."
    __gup_by_number $target
  fi

  __gup_log "New PWD: $PWD"
}

# Runs gup with numeric argument.
__gup_by_number() {
  # Cast argument to integer.
  local -i count="${1:-1}"

  if (( $count < 0 )); then
    __gup_log "Argument cannot be negative."
    return 1
  fi

  # If target is a string it will result in 0.  Alternatively, the user
  # might've entered "0" as the target. When argument is 0, we do nothing.
  if (( $count != 0 )); then
    __gup_log "Going up $count directories."

    local command="cd "
    for I in $(seq 1 $count); do
      command="$command../"
    done

    __gup_eval "$command"
  fi
}

# Runs gup with string argument.
__gup_by_string() {
  local target="$1"
  local dest=$(dirname $PWD)
  local curdir=""

  # Look for the nearest parent directory named "$target".
  while [ "$dest" != "/" ]
  do
    curdir=$(basename $dest)
    if [[ "$curdir" == "$target" ]]; then
      __gup_log "Ancestor directory \"$target\" found."
      break
    else
      __gup_log "Moving up: \"$curdir\" != \"$target\""
    fi
    dest=$(dirname $dest)
  done

  # If a matching directory was found, go to it. However,
  # if a match was not found, we should be at "/" right now.
  if [[ "$dest" == "/" ]]; then
    __gup_log "Ancestor directory \"$target\" not found."
  else
    __gup_eval "cd $dest"
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
  local message=$1
  if [ "$__GUP_VERBOSE" = true ]; then
    echo "$message"
  fi
}
