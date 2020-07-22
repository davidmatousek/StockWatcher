#!/bin/bash

set -eo pipefail

cd StockWatcher-package; swift test --parallel; cd ..
