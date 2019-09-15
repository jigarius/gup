#!/usr/bin/env bats

@test "gup: goes up 1 directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  cd /a/b/b/c/d
  gup
  [ "$PWD" == "/a/b/b/c" ]
}

@test "gup 0: stays in the same directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  cd /a/b/b/c/d
  gup 0
  [ "$PWD" == "/a/b/b/c/d" ]
}

@test "gup 3: goes up 3 directories." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  cd /a/b/b/c/d
  gup 3
  [ "$PWD" == "/a/b" ]
}

@test "gup b: goes to nearest 'b' directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  cd /a/b/b/c/d
  gup b
  [ "$PWD" == "/a/b/b" ]
}

@test "gup x: stays in the same directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  cd /a/b/b/c/d
  gup x
  [ "$PWD" == "/a/b/b/c/d" ]
}
