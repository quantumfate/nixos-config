#!/usr/bin/env bash
# Wrapper script for race conditions where windows would open before a special workspace is rendered
sleep 1
hyprctl dispatch exec [workspace special:obs] obs