#!/bin/sh

if ! command -v ghcup > /dev/null 2>&1; then
    echo "Downloading GHCup"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi

