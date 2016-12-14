# PGNetworkSDK

PGNetworkSDK is a iOS Library to manage all the network apis of PropertyGuru.

## Scripts

The project contains a folder named `Scripts` which has some helper scripts

### Generate templates

Run the below commands to quickly generate templates (request, response and responseHandler plus test file).

```
	cd Scripts
	./Templates/generate.py
```
Then follow the on-screen instructions

### Install cocoa-pods

```
	./Scripts/main.swift install
```

## Installation

### Carthage
PGNetworkSDK is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
git "git@github.com:propertyguru/PGNetworkSDK.git" "master"
```

### Cocoapods
Add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'PGNetworkSDK', :git => 'git@github.com:propertyguru/PGNetworkSDK.git', :branch=> 'master'
end
```

## Author

Suraj Pathak, freesuraj@gmail.com

## License

PGNetworkSDK is available under the MIT license. See the LICENSE file for more info.
