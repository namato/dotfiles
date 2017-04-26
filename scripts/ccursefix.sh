#!/bin/bash

# this is only used for importing
if [[ ! "$*" =~ '-i' ]] ; then
	exec /usr/local/bin/calcurse $*
fi

temp_file=$(mktemp)
temp_file_out=$(mktemp)
while read input; do
    echo $input >> $temp_file
done
/home/namato/bin/fixtz.pl $temp_file $temp_file_out
exec cat $temp_file_out | /usr/local/bin/calcurse $*
