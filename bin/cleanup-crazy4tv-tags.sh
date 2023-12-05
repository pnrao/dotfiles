#!/usr/bin/zsh

for i in *.mkv; { mkvpropedit --edit track:v1 -d name --edit track:a1 -d name --edit track:s1 -d name --set flag-default=1 --edit info --set "title=$i:r:r" $i }
