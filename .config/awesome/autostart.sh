#!/bin/bash

# Define an array of programs to start
programs=(
    "/usr/bin/emacs --daemon"
    "/usr/bin/picom --daemon"
    "/lib/polkit-kde-authentication-agent-1"
    "numlockx on"
)

# Loop through the array
for program in "${programs[@]}"; do
    # Kill any existing instances of the program
    killall "$(echo "$program" | awk '{print $1}')" >/dev/null 2>&1

    # Start the program in the background
    eval "$program" &
done
