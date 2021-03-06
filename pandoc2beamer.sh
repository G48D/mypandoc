#!/bin/bash

set -e
set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PANDOC="pandoc -S -s -N \
    --listings --template ${SCRIPT_DIR}/pandoc/templates/default.beamer \
    -F pandoc-crossref \
    -F ${SCRIPT_DIR}/pandoc/include_code.hs "

# This script uses pandoc to convert markdown to pdf. 
if [ $# -lt 1 ]; then
    echo "USAGE: ./$0 filename.pandoc [optional]"
    exit
fi

filename=$1
outputFile="${filename%.pandoc}.tex"
$PANDOC --latex-engine lualatex -tbeamer $filename -o $outputFile
lualatex --shell-escape ${outputFile} 
