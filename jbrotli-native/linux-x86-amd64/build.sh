#!/bin/sh

CURPATH=$(pwd)
VERSION=1.0.7
TARGET_CLASSES_PATH="target/classes/lib/linux-x86-amd64"
TARGET_PATH="target"

exitWithError() {
  cd ${CURPATH}
  echo "*** An error occured. Please check log messages. ***"
  exit $1
}

rm -rf "$CURPATH/${TARGET_PATH}"

# TODO CHANGE TO RELEASE
cd ../../brotli
mkdir -p out && cd out
../configure-cmake
make | exitWithError $?
make DESTDIR="${CURPATH}/${TARGET_PATH}" install
cd ${CURPATH}
mkdir -p "$CURPATH/$TARGET_CLASSES_PATH"
cp "$TARGET_PATH/usr/local/lib/libbrotlicommon.so.${VERSION}" "$CURPATH/${TARGET_CLASSES_PATH}/libbrotlicommon.so" || exitWithError $?
cp "$TARGET_PATH/usr/local/lib/libbrotlidec.so.${VERSION}" "$CURPATH/${TARGET_CLASSES_PATH}/libbrotlidec.so" || exitWithError $?
cp "$TARGET_PATH/usr/local/lib/libbrotlienc.so.${VERSION}" "$CURPATH/${TARGET_CLASSES_PATH}/libbrotlienc.so" || exitWithError $?