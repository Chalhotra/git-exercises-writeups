#!/bin/bash

check_gpg() {
    if ! command -v gpg &> /dev/null; then
        echo "GPG is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y gnupg
        echo "GPG has been installed successfully."
    else
        echo "GPG is already installed."
    fi
}

check_gpg
