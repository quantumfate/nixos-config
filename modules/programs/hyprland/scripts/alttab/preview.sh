#!/usr/bin/env bash
line="$1"

IFS=$'\t' read -r addr _ <<< "$line"
dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}

mkdir -p /tmp/alttab
grim -t png -l 0 -w "$addr" /tmp/alttab/preview.png
chafa --animate false --dither=none -s "$dim" "/tmp/alttab/preview.png"