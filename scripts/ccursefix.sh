#!/bin/bash
T1=$(mktemp)
IMPORTER=/home/namato/bin/fixtz.py
CCURSE=/usr/local/bin/calcurse

if ! [[ $* =~ "-i" ]]; then
    exec $CCURSE $*
fi

while read input; do
    echo $input >> $T1
done

exec $IMPORTER $T1 | tee $T1.out.bak | $CCURSE $*
