#!/usr/bin/env bash

function cf {
    # cd ~/Documents/cp/contests/Codeforces
    cd "$CP_HOME"
    harwest codeforces
    nvim -c "CphReceive"
    cd `cat /tmp/pwd-info`
    # -c "!cd %:p:h && pwd | pbcopy"
}
