#!/bin/bash
###########################################################
# INSTALL Protocol Buffers ON UBUNTU GNU/LINUX
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

# Install settings
###########################################################
PROTOBUF_VERSION=3.7.1
PROTOBUF_URL=https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-all-${PROTOBUF_VERSION}.tar.gz

WORKING_DIR=$(pwd)

# Add print function
###########################################################
if [ -e "print.sh" ]; then   # Add print function
    source "${WORKING_DIR}/print.sh"
else                         # Print function not found
    print() { echo "${*}"; } # Define simple print function
fi

# Install Protobuf dependencies
###########################################################
install_dependencies() {
    print yellow frame "Installing Protobuf dependencies\n"
    apt-get update --quiet

    apt-get install --yes --quiet --no-install-recommends \
        curl tar autoconf automake libtool curl make g++

    apt-get remove --yes protobuf-compiler
}

# Download, extract, configure and install Protobuf
###########################################################
install_protobuf(){
    print yellow frame "Downloading, configuring and installing Protobuf\n"

    wget -N ${PROTOBUF_URL}
    tar -xzf protobuf-all-${PROTOBUF_VERSION}.tar.gz

    set -e # Exit immediately if the pipeline fail

    cd protobuf-${PROTOBUF_VERSION}

    ./configure
    make -j"$(nproc)"
    make -j"$(nproc)" check
    make -j"$(nproc)" install
    ldconfig # Refresh shared library cache
}

# Cleanup
###########################################################
cleanup() {
    cd ${WORKING_DIR}
    rm protobuf-all-${PROTOBUF_VERSION}.tar.gz
    rm -r protobuf-${PROTOBUF_VERSION}
}

# MAIN FUNCTION
###########################################################
install_dependencies
install_protobuf
cleanup

print green frame "Protobuf $(protoc --version) installation was successful.\n"