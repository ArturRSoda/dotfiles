#!/bin/bash

# 1. Capture the screenshot
# The 'bash -c' is technically implicit here since we are in a bash script,
# but the logic remains: capture -> copy -> edit
grim -g "$(slurp)" - | tee >(wl-copy) | swappy -f -
