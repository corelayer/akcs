#!/usr/bin/env bash
SOURCE_SCRIPT="${BASH_SOURCE[0]}"

while [ -h "$SOURCE_SCRIPT" ]
do
    SOURCE_SCRIPT="$(readlink "$SOURCE_SCRIPT")"
done

SOURCE_DIR="$( cd -P "$( dirname "$SOURCE_SCRIPT" )/.." && pwd )"

rm -rf $SOURCE_DIR/output