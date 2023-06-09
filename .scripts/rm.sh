#!/usr/bin/env bash

TRASH_FOLDER="$HOME/.Trash"

function trash {
    # Iterate over the command line arguments (files to remove)
    for file in "$@"; do
        # Check if the file exists
        if [ -e "$file" ]; then
            # Generate a unique file name for the trash folder
            file_name=$(basename "$file")
            trash_file="$TRASH_FOLDER/$(date +%S)$file_name"
            # Move the file to the trash folder
            mv "$file" "$trash_file"
            # echo "Moved '$file' to '$trash_file'"
        else
            echo "File '$file' does not exist"
        fi
    done
}

alias rm=trash
