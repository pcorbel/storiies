#!/bin/sh
# HELP: Storiies
# GRID: Storiies
# ICON: Storiies

. /opt/muos/script/var/func.sh

if pgrep -f "playbgm.sh" >/dev/null; then
    killall -q "playbgm.sh" "mpg123"
fi

echo app >/tmp/act_go

APPDIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/application/Storiies"
BINDIR="$APPDIR/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPDIR/libs"

SETUP_SDL_ENVIRONMENT
SET_VAR "system" "foreground_process" "love"

cd "$APPDIR" || exit
"$BINDIR"/gptokeyb2 "love" -c "$APPDIR"/storiies.gptk &
"$BINDIR"/love .

kill -9 "$(pidof gptokeyb2)" 2>/dev/null
