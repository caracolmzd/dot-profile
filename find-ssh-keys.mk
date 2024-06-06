
MAKEFLAGS += --silent

# Valid options are: “md5” and “sha256”
FP_FORMAT ?= md5

define fingerprint
	$(eval FP = $(shell ssh-keygen -l -E ${FP_FORMAT} -f $1))
	-printf "%30s\t ${FP}\n" $1 
endef

KEYS = $(shell find -maxdepth 1 -name '*.pub' -exec basename -s .pub {} \;)

list:
	@$(foreach k,${KEYS},$(call fingerprint,$k))

find:
	@$(foreach k,${KEYS},$(call fingerprint,$k) | grep '${FIND}')

