#!/bin/zsh
#
# This lets you quickly jump into a project directory.
#
# Type:
#
#   c <tab>
#
# ...to autocomplete on all of your projects in the directories specified in
# `functions/_c`. Typically I'm using it like:
#
#    c holm<tab>/bo<tab>
#
# ...to quickly jump into holman/boom, for example.

compdef _c c

c() { cd $PROJECTS/$1; }
_c() { _files -W $PROJECTS -/; }
