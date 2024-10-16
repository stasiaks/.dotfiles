#!/bin/sh

echo "Setting locale"
localectl set-locale LANG=en_US.UTF-8
localectl set-locale LC_TIME=pl_PL.UTF-8

# Show current locale
localectl
