#!/bin/bash
# File sourced from https://github.com/ystorian/template

# This script aim to be used within `cly` (https://github.com/ystorian/cly) but can be used alone if
# cly is not installed on your system (using `./cly-hook.sh`).
# To manually symlink this script as a pre-push git hook,
# `ln -s ../../cly-hook.sh .git/hooks/pre-push` from the root of the project.

# Clippy arguments to add when enforcing these lints
# clippy_args="-- -W clippy::all -W clippy::pedantic -W clippy::restriction -W clippy::nursery \
#    -D warnings"

args=()
grep -wq "\[features\]" Cargo.toml && args+=(--all-features)
grep -wq "\[workspace\]" Cargo.toml && args+=(--workspace)

set -e -x
cargo check "${args[@]}"
cargo test "${args[@]}"
cargo clippy "${args[@]}"
cargo fmt --all --check
