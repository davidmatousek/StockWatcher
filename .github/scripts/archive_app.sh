#!/bin/bash

set -eo pipefail

xcodebuild -workspace StockWatcher.xcworkspace \
            -scheme StockWatcher\ iOS \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/StockWatcher.xcarchive \
            clean archive | xcpretty
