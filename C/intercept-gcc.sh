#!/bin/sh

# The absolute path to the real GCC compiler.
REAL_GCC=/usr/bin/gcc-13

ASAN_FLAGS="-fsanitize=address -static-libasan"

has_asan_flag=0

for arg in "$@"; do
  if [ "$arg" = "-fsanitize=address" ]; then
    has_asan_flag=$((has_asan_flag + 1))
  fi
  if [ "$arg" = "-static-libasan" ]; then
    has_asan_flag=$((has_asan_flag + 1))
  fi
  if [ "$has_asan_flag" -eq 2 ]; then
    break
  fi
done

if [ "$has_asan_flag" -eq 2 ]; then
  exec "$REAL_GCC" "$@"
else
  echo "Automatically enabling ASAN..."
  exec "$REAL_GCC" "$@" $ASAN_FLAGS
fi