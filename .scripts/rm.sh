#!/usr/bin/env bash

function trash {
    mv $@ ~/.Trash
}

alias rm=Trash
