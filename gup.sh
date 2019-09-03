#/bin/bash

gup() {
  # By default, go up once.
  COUNT="${1:-1}"

  COMMAND="cd "
  for i in {1..$COUNT}; do
    COMMAND="$COMMAND../"
  done
  eval $COMMAND
}
