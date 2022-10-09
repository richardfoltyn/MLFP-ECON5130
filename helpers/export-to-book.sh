#!/bin/bash

# Perform initial steps to merge Jupyter notebooks, export to LaTeX and
# apply initial fixes.
# pdflatex is not run as manual fixes need to be applied first!

# Determine absolute path to directory in which this files resides
# (requires readlink, which is in coreutils on Debian/Ubuntu)
MYPATH="$(dirname "$(readlink -f "$0")")"

BASEDIR=$(realpath "${MYPATH}/..")

OLDDIR="$(pwd)"

OUTFILE="MLFP-part1"

cd "${BASEDIR}/lectures"

nbmerge preface.ipynb unit*.ipynb -o "${OUTFILE}.ipynb"

jupyter nbconvert \
    --execute \
    --to=latex \
    --output-dir=${BASEDIR}/latex \
    ${OUTFILE}.ipynb

"${BASEDIR}/helpers/fix-book.sh" "${BASEDIR}/latex/${OUTFILE}.tex"

# Clean up temp files
rm "${OUTFILE}.ipynb"
if [ -d "raw.githubusercontent.com" ]; then
    rm -rf "raw.githubusercontent.com"
fi

cd "${OLDDIR}"