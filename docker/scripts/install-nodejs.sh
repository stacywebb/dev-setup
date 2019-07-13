#!/bin/bash
###########################################################
# INSTALL Node.js ON UBUNTU GNU/LINUX
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

# Install settings
###########################################################
NODE_VERSION=v10.15.3
NODE_DISTRO=linux-x64
NODE_FILE_NAME=node-${NODE_VERSION}-${NODE_DISTRO}
NODE_URL=http://nodejs.org/dist/${NODE_VERSION}/${NODE_FILE_NAME}.tar.xz

WORKING_DIR=$(pwd)

# Add print function
###########################################################
if [ -e "print.sh" ]; then   # Add print function
    source "${WORKING_DIR}/print.sh"
else                         # Print function not found
    print() { echo "${*}"; } # Define simple print function
fi

# Install Node.js dependencies
###########################################################
install_dependencies() {
    print yellow frame "STARTING Node.js ${NODE_VERSION} installation!\n"
    apt-get update --quiet

    apt-get install --yes --quiet --no-install-recommends \
        curl tar
}

# Download, extract and install Node.js
###########################################################
install_nodejs(){
    print yellow frame "Downloading, extracting and installing Node.js\n"

    mkdir -p "/usr/local/lib/nodejs"
    curl ${NODE_URL} | tar -xJC /usr/local/lib/nodejs

    ln -s /usr/local/lib/nodejs/${NODE_FILE_NAME}/bin/node /usr/bin/node
    ln -s /usr/local/lib/nodejs/${NODE_FILE_NAME}/bin/npm /usr/bin/npm
    ln -s /usr/local/lib/nodejs/${NODE_FILE_NAME}/bin/npx /usr/bin/npx
}

# MAIN FUNCTION
###########################################################
install_dependencies
install_nodejs

print green frame "Node.js ${NODE_VERSION} installation was successful\n"