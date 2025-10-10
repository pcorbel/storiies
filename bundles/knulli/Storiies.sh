#!/bin/sh

APPDIR="$(dirname "$(readlink -f "$0")")"/Storiies
BINDIR="$APPDIR/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPDIR/libs"

cd "$APPDIR" || exit
"$BINDIR"/gptokeyb2 "love" -c "$APPDIR"/storiies.gptk &
"$BINDIR"/love .

kill -9 "$(pidof gptokeyb2)" 2>/dev/null
