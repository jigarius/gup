# Gup version.
__GUP_VERSION="1.5"

# Gup entry-point.
gup() {
  local method="exec"

  # Verbose mode.
  __GUP_VERBOSE=false
  # Target.
  local target=""
  local force_number=""

  # Parse arguments.
  while [ $# -ne 0 ]
  do
    case "$1" in
      --verbose|-v) __GUP_VERBOSE=true ;;
      --interactive|-i) method="interactive" ;;
      --version) method="version" ;;
      --number|-n) force_number=true ;;
      *) target="$1"; break ;;
    esac
    shift
  done

  # Call method as per command.
  __gup_log "Calling __gup_$method()"
  case "$method" in
    "exec") __gup_exec "$target" $force_number ;;
    "interactive") __gup_interactive ;;
    "version") __gup_version ;;
  esac
}

# Executes gup on an argument.
#
# Usage: gup <target> <force-number>
__gup_exec() {
  # Get the current working directory.
  local pwd_old="$PWD"
  __gup_log "Old PWD: $pwd_old"

  # Determine target.
  local target="$1"

  # Is the target forceably a number?
  local force_number="$2"

  # If target is empty, force it as the number "1".
  if [[ -z "$target" ]]; then
    target=1
    force_number=true
  fi

  __gup_log "Target is: $target."

  # Treat target as a string first, unless it is forced to be a number.
  # This looks up ancestor directories with numeric names, if any.
  if [[ -z "$force_number" ]]; then
    __gup_log "Treating target as a string."
    __gup_by_string $target
  else
    __gup_log "--number flag detected."
  fi

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
    __gup_eval "cd \"$dest\""
  fi
}

# Displays version information.
#
# Usage: __gup_version
__gup_version() {
  echo "gup $__GUP_VERSION"
  if [[ $__GUP_VERBOSE == true ]]; then
    echo "Author: Jigarius | jigarius.com"
    echo "GitHub: github.com/jigarius/gup"
  fi
}

# Allows user to choose the directory they want to go up to.
#
# Usage: __gup_interactive
__gup_interactive() {
  local dest=$(dirname $PWD)
  local curdir=""
  local -a choices=()

  # Collect all directory names in $PWD.
  while [ "$dest" != "/" ]
  do
    curdir=$(basename $dest)
    choices+=( "$curdir" )
    dest=$(dirname $dest)
  done

  # Generate a menu.
  echo "Choose a destination directory:"
  select choice in "${choices[@]}"; do
    # If the choice is invalid, do nothing.
    if [[ -z $choice ]]; then
      __gup_log "Choice invalid. Doing nothing."
      return 1
    fi

    # Determine the number of levels we have to go up.
    local -i count="$REPLY"
    __gup_log "Option chosen: $REPLY ($choice), i.e. go up $count directories."

    # Execute gup with the number of levels to go up.
    __gup_exec $count true

    return 0
  done
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
