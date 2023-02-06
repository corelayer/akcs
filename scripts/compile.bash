#!/usr/bin/env bash
clear
echo "Building AuthorizedKeysCommand Service"
echo "--------------------------------------"
if [ -z "$1" ]
then
    echo "No application command defined."
    echo "Run: make compile APPCMD=<command> or bash scripts/compile.bash <command>"
    exit 0
fi
APPCMD=$1

SOURCE_SCRIPT="${BASH_SOURCE[0]}"

while [ -h "$SOURCE_SCRIPT" ]
do
    SOURCE_SCRIPT="$(readlink "$SOURCE_SCRIPT")"
done

SOURCE_DIR="$( cd -P "$( dirname "$SOURCE_SCRIPT" )/.." && pwd )"

// --> Points to the command that needs to be compiled
APPCMD_DIR=$SOURCE_DIR/cmd/$APPCMD

OUTPUT_DIR=$SOURCE_DIR/output
OUTPUT_FILENAME=$APPCMD

cd "$APPCMD_DIR"

echo "Cleaning up previous builds and packages"
rm -rf $OUTPUT_DIR

echo "Build executables per platform"
OUTPUT="$OUTPUT_DIR/linux/amd64/$OUTPUT_FILENAME"
echo " - linux-amd64 --> $OUTPUT"
GOOS=linux GOARCH=amd64 go build -o $OUTPUT main.go

OUTPUT="$OUTPUT_DIR/windows/amd64/$OUTPUT_FILENAME.exe"
echo " - windows-amd64 --> $OUTPUT"
GOOS=windows GOARCH=amd64 go build -o $OUTPUT main.go

OUTPUT="$OUTPUT_DIR/darwin/amd64/$OUTPUT_FILENAME"
echo " - darwin-amd64 --> $OUTPUT"
GOOS=darwin GOARCH=amd64 go build -o $OUTPUT main.go

OUTPUT="$OUTPUT_DIR/darwin/arm64/$OUTPUT_FILENAME"
echo " - darwin-arm64 --> $OUTPUT"
GOOS=darwin GOARCH=arm64 go build -o $OUTPUT main.go

OUTPUT="$OUTPUT_DIR/freebsd/amd64/$OUTPUT_FILENAME"
echo " - freebsd-amd64 --> $OUTPUT"
GOOS=freebsd GOARCH=amd64 go build -o $OUTPUT main.go