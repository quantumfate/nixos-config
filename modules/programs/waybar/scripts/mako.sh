#!/usr/bin/env bash

# Use makoctl list to count the *currently visible* notifications.
# The 'jq' tool is used to parse the JSON output from makoctl.
COUNT=$(makoctl list | jq '.data | length')

# Define your icons
ENABLED="" # Your enabled icon (e.g., Bell)
DISABLED="" # Your disabled/paused icon (e.g., Bell Slash)
COUNT_ICON="" # Your icon for showing the count (e.g., Bell with Count)

# Check if Do Not Disturb mode is active
# Mako's equivalent to pausing is often a mode like 'dnd' or 'do-not-disturb'
# Change 'do-not-disturb' below if you use a different mode name in your mako config.
DND_MODE="do-not-disturb"
DND_ACTIVE=$(makoctl mode | grep -q "${DND_MODE}" ; echo $?)

# Logic to determine the output
if [ "$DND_ACTIVE" -eq 0 ]; then
    # Mako is in Do Not Disturb mode (DND_ACTIVE is 0 if grep found the mode)
    # Check if there are notifications waiting (like the dunstctl count waiting)
    if [ "$COUNT" -ne 0 ]; then
        echo "${COUNT_ICON} ${COUNT}" # Paused/DND mode with count of visible notifications
    else
        echo "${DISABLED}" # Paused/DND mode, but no visible notifications
    fi
else
    # Mako is *not* in Do Not Disturb mode (notifications are active)
    echo "${ENABLED}"
fi