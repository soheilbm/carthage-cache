TEMPORARY_FOLDER?=/tmp/CarthageCache.dst
BUILD_TOOL?=xcodebuild

XCODEFLAGS=-scheme 'carthage-cache'  \
	-configuration Release \
	-derivedDataPath '$(TEMPORARY_FOLDER)' \
	OTHER_LDFLAGS=-Wl,-headerpad_max_install_names \
	clean build


BINARIES_FOLDER=/usr/local/bin

.PHONY: install copy clean

install: 
	echo "installing"
	$(BUILD_TOOL) $(XCODEFLAGS)

clean:
	echo "cleaning temp folder"
	rm -rf "$(TEMPORARY_FOLDER)"

copy:
	echo "copying item"
	cp -f "$(TEMPORARY_FOLDER)/Build/Products/Release/carthage-cache" "$(BINARIES_FOLDER)/carthage-cache"