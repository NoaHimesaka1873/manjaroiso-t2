#!/bin/bash
layout="$(localectl status | grep Layout | cut -d ':' -f 2)"
setxkbmap $layout
