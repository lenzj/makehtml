#!/bin/sh

RTEMPLATE=../../repo-template

if [ -d $RTEMPLATE ]
then
        echo "Generating README.md"
        pgot -i ":$RTEMPLATE" -o ../README.md README.md.got
        echo "Generating LICENSE"
        pgot -i ":$RTEMPLATE" -o ../LICENSE ${RTEMPLATE}/LICENSE.src/BSD-2-clause.got
else
        echo "$RTEMPLATE repository not found."
        exit 1
fi
