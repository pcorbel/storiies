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
PM_DIR="$(GET_VAR "device" "storage/rom/mount")/MUOS/PortMaster"
BINDIR="$APPDIR/bin"

SETUP_SDL_ENVIRONMENT
export LD_LIBRARY_PATH="$PM_DIR:$APPDIR/libs:$LD_LIBRARY_PATH"

cd "$APPDIR" || exit
SET_VAR "system" "foreground_process" "love"

"$PM_DIR"/gptokeyb2 "love" -c "$APPDIR"/storiies.gptk &

"$BINDIR"/love .

kill -9 "$(pidof gptokeyb2)" 2>/dev/null
