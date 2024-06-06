list-keys:
	gpg --list-keys --fingerprint

list-key-ids:
	@gpg --list-keys --with-colons | awk -F: '/^[sp]ub:/ {print $$1 ": " $$5}  /uid:/ {print $$1 ": " $$10} END {print "---"}'

import-key:
	gpg --import ${KEY_FILE}

export-key:
	gpg --export --armor ${KEY_ID} > ${OUTPUT}