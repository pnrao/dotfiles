#!/usr/bin/zsh

grep -v "^#" /mnt/bluewest/Music/Portable.m3u|sort|tr '\n' '\0' > /tmp/Portable.list

cd /mnt/bluewest/Music

# rsync -avzn --port=2222 --files-from=/tmp/Portable.list /mnt/bluewest/Music 192.168.1.6:/storage/66F6-0D80/Music/

for i in `xargs -a /tmp/Portable.list`
do
	echo $i:t
done
