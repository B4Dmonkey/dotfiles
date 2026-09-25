#!/bin/bash
# Build throwaway git repos, one per state, under $1.
set -e
F=$1; rm -rf "$F"; mkdir -p "$F"; cd "$F"
g() { git -c user.name=t -c user.email=t@t -c init.defaultBranch=main -c advice.detachedHead=false "$@" >/dev/null 2>&1; }
mk() { mkdir "$1"; (cd "$1" && g init && echo a > f && g add f && g commit -m a); }
mk clean
mk dirty;     echo b >> dirty/f
mk untracked; touch untracked/new
mk stashed;   (cd stashed && echo b >> f && g stash)
mk remote
g clone remote ahead;  (cd ahead && echo c >> f && g commit -am c)
g clone remote behind; (cd remote && echo d >> f && g commit -am d); (cd behind && g fetch)
mk rebase; (cd rebase && g checkout -b x && echo x > f && g commit -am x && g checkout main && echo y > f && g commit -am y && (g rebase x 2>/dev/null || true))
