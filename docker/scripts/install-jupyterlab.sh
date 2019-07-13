#!/bin/bash
###########################################################
# INSTALL Jupyterlab ON UBUNTU GNU/LINUX
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

# Install Jupyterlab
###########################################################
install_jupyterlab() {
    print yellow frame "STARTING Jupyterlab installation\n"

    pip install --no-cache-dir --upgrade \
        pip \
        jupyterlab \
        jupyterlab-git
}

# Install Jupyterlab extensions (Require Node.js)
###########################################################
install_labextension() {
    set -e # Exit immediately if the pipeline fail

    print yellow frame "Installing Jupyterlab extensions\n"
    jupyter labextension install @jupyterlab/toc

    jupyter labextension install @jupyterlab/git
    jupyter serverextension enable --py jupyterlab_git

    jupyter labextension install @jupyter-widgets/jupyterlab-manager
    jupyter labextension install jupyter-matplotlib
}

# Cleanup
###########################################################
cleanup() {
    print yellow frame "Cleanup - removing temporary files\n"
    npm cache clean --force
}

# MAIN FUNCTION
###########################################################
install_jupyterlab
install_labextension
cleanup

print green frame "Jupyterlab installation was successful\n"