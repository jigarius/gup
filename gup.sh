# Gup entry-point.
gup() {
  # By default, go up once.
  declare -i COUNT="${1:-1}"

  COMMAND="cd "
  for i in $(seq 1 $COUNT); do
    COMMAND="$COMMAND../"
  done

  eval $COMMAND
}
