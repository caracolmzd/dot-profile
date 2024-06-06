list-keys:
	gpg --list-keys --fingerprint

list-key-ids:
	@gpg --list-keys --with-colons | awk -F: '/^[sp]ub:/ {print $$1 ": " $$5}  /uid:/ {print $$1 ": " $$10} END {print "---"}'

import-key:
	gpg --import ${KEY_FILE}

export-key:
	gpg --export --armor ${KEY_ID} > ${OUTPUT}

export-secret-key:
	gpg --export-secret-keys --armor ${KEY_ID} > ${OUTPUT}

generate-key:
	gpg --full-generate-key