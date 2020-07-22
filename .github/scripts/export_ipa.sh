#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/StockWatcher.xcarchive \
            -exportOptionsPlist StockWatcher/StockWatcher\ iOS/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty
