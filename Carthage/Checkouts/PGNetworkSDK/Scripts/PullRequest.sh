#!/bin/sh

# updates carthage dependencies
echo 'Updating carthage'
./Scripts/main.swift install
# perform Unit test
xcodebuild test -scheme PGNetworkSDK -destination platform=iOS\ Simulator,name=iPhone\ 6,OS=10.0 | xcpretty
# generate report
# slather coverage --html --scheme PGNetworkSDK PGNetworkSDK.xcodeproj
slather coverage -x --scheme PGNetworkSDK PGNetworkSDK.xcodeproj
# lineCoverage=`echo "cat //coverage/@line-rate" | xmllint --shell ./cobertura.xml | grep -v ">" | cut -f 2 -d "=" | tr -d \"`
