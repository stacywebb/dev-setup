#!/bin/bash
###########################################################
# INSTALL Python Libraries ON UBUNTU GNU/LINUX
#
# Copyright (c) Marcos Gomes-Borges
###########################################################
WORKING_DIR=$(pwd)

# Add print function
###########################################################
if [ -e "print.sh" ]; then   # Add print function
    source "${WORKING_DIR}/print.sh"
else                         # Print function not found
    print() { echo "${*}"; } # Define simple print function
fi

# Install Python libraries
###########################################################
install_pylibs(){
    print yellow frame "STARTING Python libraries installation\n"

    pip install --no-cache-dir --upgrade pip

    # Keras
    pip install --no-cache-dir --upgrade \
        h5py \
        pydot \
        keras

    # Specific libraires
    pip install --no-cache-dir  --upgrade \
        pandas \
        scipy \
        pillow \
        scikit-learn \
        scikit-image \
        sk-video

    # Basic libraries
    pip install --no-cache-dir --upgrade \
        progressbar2 \
        requests \
        Cython \
        pylint \
        autopep8 \
        pytest \
        pydocstyle

    # Matplotlib
    pip install --no-cache-dir --upgrade \
        ipympl \
        matplotlib

    # Fix Matplotlib backend
    mkdir -p "${HOME}/.config/matplotlib"
    echo "backend : TkAgg" > "${HOME}/.config/matplotlib/matplotlibrc"
}

# MAIN FUNCTION
###########################################################
install_pylibs

print green frame "Python libraries installation was successful\n"