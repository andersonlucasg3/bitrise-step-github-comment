#!/bin/bash
set -ex

function install_swift () {
    sudo apt-get install clang
    sudo apt-get install libcurl3 libpython2.7 libpython2.7-dev

    wget https://swift.org/builds/swift-5.1.3-release/ubuntu1804/swift-5.1.3-RELEASE/swift-5.1.3-RELEASE-ubuntu18.04.tar.gz
    tar xzf swift-5.1.3-RELEASE-ubuntu18.04.tar.gz
    sudo mv swift-5.1.3-RELEASE-ubuntu18.04 /usr/share/swift
    export PATH=/usr/share/swift/usr/bin:$PATH
    swift --version
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
