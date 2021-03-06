#!/bin/sh
set -e

CONFIG="/vagrant/dos-config"
SOURCES="/vagrant/sources.list"

[ -f "${CONFIG}" ] && . ${CONFIG} && echo "I: Using local configuration"

BUILD_DIR="${HOME}/digabi-os"

if [ ! -d "${BUILD_DIR}" ]
then
    echo "I: Clone git repository..."
    git clone /digabi-os.git ${BUILD_DIR}
fi

echo "I: Checkout git repository..."
cd ${BUILD_DIR}
git checkout ${COMMIT:-HEAD}

echo "I: Copy local configuration to build directory..."
cp ${CONFIG} ${BUILD_DIR}/target/default/digabi.local

echo "I: Copy local sources.list configuration to build directory..."
cp ${SOURCES} ${BUILD_DIR}/target/default/archives/digabi.list.binary
cp ${SOURCES} ${BUILD_DIR}/target/default/archives/digabi.list.chroot

echo "I: Running lb config..."
lb config ${LB_OPTIONS}

