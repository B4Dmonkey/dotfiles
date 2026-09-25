#!/bin/bash
# Tests for starship-segment: starship's directory + git modules as tmux styles.
here=$(cd "$(dirname "$0")" && pwd)
seg="$here/../starship-segment"
fx=$(mktemp -d)/fx; trap 'rm -rf "${fx%/fx}"' EXIT
fails=0

check() { # name expected actual
  if [ "$2" == "$3" ]; then echo "ok   $1"
  else echo "FAIL $1"; echo "  want: $2"; echo "  got:  $3"; fails=$((fails+1)); fi
}

R='#[fg=default none]'
ZW=$'​'

# Colour conversion, independent of git.
check "green"      "#[fg=green]clean$R "        "$(printf '\e[32mclean\e[0m ' | "$seg" --convert)"
check "bright grey" "#[fg=brightblack]main$R"   "$(printf '\e[90mmain\e[0m' | "$seg" --convert)"
check "256 colour"  "#[fg=colour218]*#[fg=cyan] $R" "$(printf '\e[38;5;218m*\e[36m \e[0m' | "$seg" --convert)"
check "plain text"  "no escapes here"           "$(printf 'no escapes here' | "$seg" --convert)"

# Git states, from real repos rendered by the real starship config.
"$here/make-fixtures.sh" "$fx"
d() { printf '#[fg=green]%s%s ' "$1" "$R"; }
b="#[fg=brightblack]main$R"
check "clean"     "$(d clean)$b#[fg=cyan] $R"                          "$("$seg" "$fx/clean")"
check "dirty"     "$(d dirty)$b#[fg=colour218]*$ZW#[fg=cyan] $R"       "$("$seg" "$fx/dirty")"
check "untracked" "$(d untracked)$b#[fg=colour218]*$ZW#[fg=cyan] $R"   "$("$seg" "$fx/untracked")"
check "stashed"   "$(d stashed)$b#[fg=cyan] ≡$R"                       "$("$seg" "$fx/stashed")"
check "ahead"     "$(d ahead)$b#[fg=cyan] ⇡$R"                         "$("$seg" "$fx/ahead")"
check "behind"    "$(d behind)$b#[fg=cyan] ⇣$R"                        "$("$seg" "$fx/behind")"
check "rebase"    "$(d rebase)#[fg=brightblack]HEAD$R(#[fg=brightblack]REBASING 1/1$R) #[fg=colour218]*$ZW#[fg=cyan] $R" "$("$seg" "$fx/rebase")"

# tmux's #() shows only the last line of output.
check "one line"  "1" "$(printf '%s' "$("$seg" "$fx/dirty")" | grep -c '')"

[ $fails -eq 0 ] && echo "all passed" || { echo "$fails failed"; exit 1; }
