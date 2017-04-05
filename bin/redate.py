#!/usr/bin/env python

import sys
import os
from pathlib import Path

def redate(f):
	from datetime import datetime, timezone
	from pprint import pprint
	import xattr             # pip install pyxattr --user
	import json
	from imdbpie import Imdb # pip install imdbpie --user
	import errno
	try:
		year, month, date = 0, 0, 0
		j = json.loads(xattr.getxattr(f, 'user.net.filebot.metadata').decode('utf-8'))
		if 'airdate' in j:
			# detected a TV episode; will set the full date
			year = j['airdate']['year']
			month = j['airdate']['month']
			date = j['airdate']['day']
		elif 'imdbId' in j:
			# detected a movie; filebot does not fill in complete dates, so we get it from IMDB
			imdbId = 'tt%07d'%j['imdbId']
			t = Imdb().get_title_by_id(imdbId)
			if t.release_date:
				year, month, date = map(int, t.release_date.split('-'))
			else:
				print('Missing date information for "%s"' % f)
				return
		else:
			# filebot probably did not fill in the required info; ignore for now
			print("Insufficient data to redate %s" % f)
			# pprint(j)
			return
		dt = datetime(year, month, date, 12, tzinfo=timezone.utc).timestamp()
		# It's not straightforward to get the timezone of the release date
		# so we settle on 12 noon UTC as a compromise.
		os.utime(f, (dt, dt))
	except OSError as e:
		if e.errno in [errno.ENODATA, errno.ENOTSUP, errno.EOPNOTSUPP]:
			print('"%s": filebot xattrs missing'%f, file=sys.stderr)
		else:
			print("Unexpected error:", sys.exc_info()[0], file=sys.stderr)
			raise
	except:
		print("Unexpected error:", sys.exc_info()[0], file=sys.stderr)
		raise


if __name__ == '__main__':
	if len(sys.argv) < 2:
		print('Usage: %s <list of files>'%sys.argv[0], file=sys.stderr)
		sys.exit(1)
	for x in sys.argv[1:]:
		p = Path(x)
		#if p.is_dir(): # Not sure this option is all that useful
		#	print('to be implemented later', file=sys.stderr)
		#	sys.exit(2)
		if p.is_file():
			redate(p.as_posix())
