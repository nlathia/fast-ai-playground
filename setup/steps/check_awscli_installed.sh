#!/bin/bash

hash aws 2>/dev/null
if [ $? -ne 0 ]; then
    echo >&2 "'aws' command line tool required, but not installed. Aborting."
    exit 1
fi
