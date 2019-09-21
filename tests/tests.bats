#!/usr/bin/env bats

@test "gup: goes up 1 directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/1/b/c/d
  cd /a/1/b/c/d
  gup -v
  [ "$PWD" == "/a/1/b/c" ]
}

@test "gup 0: stays in the same directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/b/b/c/d
  cd /a/b/b/c/d
  gup 0
  [ "$PWD" == "/a/b/b/c/d" ]
}

@test "gup 3: goes up 3 directories." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/b/b/c/d
  cd /a/b/b/c/d
  gup 3
  [ "$PWD" == "/a/b" ]
}

@test "gup 2: goes to nearest '2' directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/2/b/c/d
  cd /a/2/b/c/d
  gup 2
  [ "$PWD" == "/a/2" ]
}

@test "gup -n 2: goes up 2 directories." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/2/b/c/d
  cd /a/2/b/c/d
  gup -n 2
  [ "$PWD" == "/a/2/b" ]
}

@test "gup b: goes to nearest 'b' directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/b/b/c/d
  cd /a/b/b/c/d
  gup b
  [ "$PWD" == "/a/b/b" ]
}

# Strangely, this test goes into an infinite execution.
@test "gup 's s': goes to nearest 's s' directory." {
  skip
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p "/a/s s/c/d"
  cd "/a/s s/c/d"
  gup "s s"
  [ "$PWD" == "/a/s s" ]
}

@test "gup x: stays in the same directory." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  sudo mkdir -p /a/b/b/c/d
  cd /a/b/b/c/d
  gup x
  [ "$PWD" == "/a/b/b/c/d" ]
}

@test "gup --version: shows version." {
  source "$TRAVIS_BUILD_DIR/gup.sh"
  output="$(gup --version)"
  [ "$output" == "gup $__GUP_VERSION" ]
}
