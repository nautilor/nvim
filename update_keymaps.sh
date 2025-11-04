#!/usr/bin/env bash

echo '| Mode | Keybind | Command | Extra |' > KEYMAP.md
echo '|------|---------|----------|--------|' >> KEYMAP.md

while read -r keymap; do
	awk '
		BEGIN { FS = "," } ; {
			if ( match($1, /^\{/) ) { 
				print " ", $1, ",", $2, " | ", $3, " | ", $4, " | ", $5, " "
			} else {
				print " ", $1, " | ", $2, " | ", $3, " | ", $4, " "
			}
		}
	' < <(echo $keymap | sed -E 's/^\(|\)//g') >> KEYMAP.md

done < <(grep -r '^keymap' lua/. | sed -E 's/.*lua:\s{1,}?.*keymap\.set//g')

