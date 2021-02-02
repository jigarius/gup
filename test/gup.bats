#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/../gup.sh"

setup() {
  cd $BATS_TMPDIR
}

@test "gup --version: shows version." {
  output="$(gup --version)"
  [ "$output" == "gup $__GUP_VERSION" ]
}

@test "gup: goes up 1 directory." {
  mkdir -p a/1/b/c/d
  cd a/1/b/c/d
  gup -v
  [ "$PWD" == "$BATS_TMPDIR/a/1/b/c" ]
}

@test "gup 0: stays in the same directory." {
  mkdir -p a/b/b/c/d
  cd a/b/b/c/d
  gup -v 0
  [ "$PWD" == "$BATS_TMPDIR/a/b/b/c/d" ]
}

@test "gup 3: goes up 3 directories." {
  mkdir -p a/b/b/c/d
  cd a/b/b/c/d
  gup -v 3
  [ "$PWD" == "$BATS_TMPDIR/a/b" ]
}

@test "gup 2: goes to nearest '2' directory." {
  mkdir -p a/2/b/c/d
  cd a/2/b/c/d
  gup -v 2
  [ "$PWD" == "$BATS_TMPDIR/a/2" ]
}

@test "gup -n 2: goes up 2 directories." {
  mkdir -p a/2/b/c/d
  cd a/2/b/c/d
  gup -v -n 2
  [ "$PWD" == "$BATS_TMPDIR/a/2/b" ]
}

@test "gup b: goes to nearest 'b' directory when 2 'b' directories exist." {
  mkdir -p a/b/b/c/d
  cd a/b/b/c/d
  gup -v b
  [ "$PWD" == "$BATS_TMPDIR/a/b/b" ]
}

@test "gup b: goes to nearest 'b' directory even if current directory is 'b'." {
  mkdir -p a/b/b
  cd a/b/b
  gup -v b
  [ "$PWD" == "$BATS_TMPDIR/a/b" ]
}

@test "gup 's s': goes to nearest 's s' directory." {
  mkdir -p "a/s s/c/d"
  cd "a/s s/c/d"
  gup -v "s s"
  [ "$PWD" == "$BATS_TMPDIR/a/s s" ]
}

@test "gup x: stays in the same directory." {
  mkdir -p a/b/b/c/d
  cd a/b/b/c/d
  gup -v x
  [ "$PWD" == "$BATS_TMPDIR/a/b/b/c/d" ]
}
