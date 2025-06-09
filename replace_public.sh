#!/bin/bash
# Replace all occurrences of 'public/' with '' in all files under application/

export LC_CTYPE=C
find ./application -type f -exec sed -i '' "s/public\///g" {} +