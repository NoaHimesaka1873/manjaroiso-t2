#!/bin/sh

# Give us some room to configure things:
export XDG_DATA_DIRS
XDG_DATA_DIRS="/usr/share/manjaro:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
