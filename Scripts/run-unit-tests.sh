#!/bin/sh

#  run-unit-tests.sh
#  BikeShare
#
#  Created by Daniel Slone on 3/2/20.
#  Copyright © 2020 Daniel Slone. All rights reserved.

set -eo pipefail

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

WORKSPACE_PATH='BikeShare.xcworkspace'
TESTS_SCHEME='Bike Share: Debug, Unit Tests only'

XCODEBUILD_DESTINATION="platform=iOS Simulator,name=iPhone X"

echo "---"
echo "++ Running Bootstrap"
echo "---"
echo

bundle install --local

echo "---"
echo "++ Running Xcode tests"
echo "---"
echo

WORK_DIR='./unit-test-output'

# Xcode requires the DIR to be empty/not there
rm -rf $WORK_DIR

# deletes the temp directory
function cleanup {

    # Upload to buildkite if the agent is available
    if hash buildkite-agent 2>/dev/null; then

        zip -r test_artifact.zip $WORK_DIR

        buildkite-agent artifact upload test_artifact.zip

          rm test_artifact.zip
      fi

      rm -rf "$WORK_DIR"
      echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

xcodebuild -workspace "$WORKSPACE_PATH" -scheme "$TESTS_SCHEME" clean

xcodebuild -workspace "$WORKSPACE_PATH" -scheme "$TESTS_SCHEME" test -destination "$XCODEBUILD_DESTINATION" -resultBundlePath "$WORK_DIR" | bundle exec xcpretty
