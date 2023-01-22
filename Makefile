#! /usr/bin/make -f

# @see https://zenn.dev/re24_1986/articles/29430f2f8b4b46

ORACLE_DB_IMAGE_DIR=docker-images/OracleDatabase/SingleInstance/dockerfiles
ORACLE_DB_VERSION=19.3.0
ORACLE_DB_VERSION_SYMBOL=193000
ORACLE_DB_IMAGE_FILE=LINUX.X64_$(ORACLE_DB_VERSION_SYMBOL)_db_home.zip
ORACLE_DB_IMAGE_PATH=$(ORACLE_DB_IMAGE_DIR)/$(ORACLE_DB_VERSION)/$(ORACLE_DB_IMAGE_FILE)

.PHONY: all build build-oracle-db$(ORACLE_DB_VERSION)e-docker-image clean

all: build
build: build-oracle-db$(ORACLE_DB_VERSION)e-docker-image 
build-oracle-db$(ORACLE_DB_VERSION)e-docker-image: $(ORACLE_DB_IMAGE_PATH)
	cd $(ORACLE_DB_IMAGE_DIR) && ./buildContainerImage.sh -v $(ORACLE_DB_VERSION) -e -i
$(ORACLE_DB_IMAGE_PATH): docker-images
	cp $(ORACLE_DB_IMAGE_FILE) $(ORACLE_DB_IMAGE_DIR)/$(ORACLE_DB_VERSION)/
docker-images:
	git clone https://github.com/oracle/docker-images.git
clean:
	rm -rf docker-images
