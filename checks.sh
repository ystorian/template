#!/bin/bash
# File sourced from https://github.com/ystorian/template

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
