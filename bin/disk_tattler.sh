#!/usr/bin/env sh

OUTFILE=~/public_html/space_used.txt

# reinits file
echo "** Disk usage by user on `hostname` **" > $OUTFILE
echo "Run date: `date`\n" >> $OUTFILE

# space count
du --max-depth=1 /home | sort -nr >> $OUTFILE
