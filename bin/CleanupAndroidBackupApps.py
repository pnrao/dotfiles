#!/usr/bin/python3

import os
import sys
import glob
from pprint import pprint
from collections import defaultdict
from packaging import version

os.chdir('/mnt/bluewest/Downloads/Android/backups')
fnames = glob.glob('*.apk')

d = defaultdict(list)

for f in fnames:
	try:
		app, ver = f.split('  ')
		d[app].append(ver)
	except ValueError: # Some apk files do not have two spaces as the separator
		pass

for app in list(d.keys()):
	d[app].remove(max(d[app], key = version.parse))
	for ver in d[app]:
		print('deleting', '  '.join([app, ver]))
		os.remove('  '.join([app, ver]))

