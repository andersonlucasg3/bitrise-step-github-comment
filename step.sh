#!/bin/bash
set -ex

function install_swift () {
    brew install swift;
}

if ! [ -x "$(command -v swift)" ] 
then
    echo "swift is not installed, installing..."
    install_swift
else
    echo "swift already installed, continuing..."
fi

echo "building source..."

swift build --configuration release

./.build/release/GithubComment $GITHUB_TOKEN $GITHUB_BRANCH $GITHUB_OWNER $GITHUB_REPO $GITHUB_ENVIRONMENT $GITHUB_TARGET_URL
