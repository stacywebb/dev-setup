#!/bin/bash
###########################################################
# INSTALL Opencv ON UBUNTU GNU/LINUX
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

# Install settings
###########################################################
OPENCV_VERSION=4.1.0
OPENCV_URL=https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz
OPENCV_CONTRIB_URL=https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz

py3_exec=$(which python3)
py3_config=$(python3 -c "from distutils.sysconfig import get_config_var as s; print(s('LIBDIR'))")
py3_include=$(python3 -c "import distutils.sysconfig as s; print(s.get_python_inc())")
py3_packages=$(python3 -c "import distutils.sysconfig as s; print(s.get_python_lib())")
py3_numpy=$(python3 -c "import numpy; print(numpy.get_include())")

WORKING_DIR=$(pwd)

# Add print function
###########################################################
if [ -e "print.sh" ]; then   # Add print function
    source "${WORKING_DIR}/print.sh"
else                         # Print function not found
    print() { echo "${*}"; } # Define simple print function
fi

# Check if a GPU is available
###########################################################
nvidia_gpu_available() {
    if [[ $(lspci | grep -i nvidia) ]]; then
        echo 1
    else
        echo 0
    fi
}

# Install Opencv dependencies
###########################################################
install_dependencies() {
    print yellow frame "Installing Opencv dependencies\n"

    apt-get update --quiet

    apt-get install --yes --quiet --no-install-recommends \
        autoconf automake build-essential ca-certificates cmake git libtool wget

    # Image and video I/O libraries
    apt-get install --yes --quiet --no-install-recommends \
        libjpeg-dev libpng-dev libtiff-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libdc1394-22-dev \
        libfaac-dev libmp3lame-dev libtheora-dev \
        libvorbis-dev libxvidcore-dev \
        libopencore-amrnb-dev libopencore-amrwb-dev \
        libavresample-dev \
        libxvidcore-dev libx264-dev x264 \
        libjasper-dev

    # Mathematical optimizations
    apt-get install --yes --quiet --no-install-recommends \
        gfortran libatlas-base-dev libtbb-dev libatlas-base-dev

    # Optional dependencies
    # libprotobuf-dev protobuf-compiler (compiled and installed from source)
    apt-get install --yes --quiet --no-install-recommends \
        libeigen3-dev libhdf5-dev \
        libgflags-dev \
        qt5-default
}

# Download, configure and install Opencv
###########################################################
install_opencv() {
    # Check GPU support
    if [ $(nvidia_gpu_available) != 0 ]; then
        print green frame "NVIDIA GPU detected\n"
        CUDA_ON_OFF=ON
    else
        print red frame "NVIDIA GPU NOT detected\n"
        CUDA_ON_OFF=OFF
    fi

    set -e # Exit immediately if the pipeline fail

    # Download, configure and install Opencv
    print yellow frame "Downloading, configuring and installing Opencv\n "

    wget -O opencv.tar.gz ${OPENCV_URL}
    wget -O opencv_contrib.tar.gz ${OPENCV_CONTRIB_URL}

    tar -xzf opencv.tar.gz
    tar -xzf opencv_contrib.tar.gz

    mkdir -p "opencv-${OPENCV_VERSION}/build"
    cd "opencv-${OPENCV_VERSION}/build"

    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH="../../opencv_contrib-${OPENCV_VERSION}/modules" \
          -D ENABLE_PRECOMPILED_HEADERS=OFF \
          -D WITH_CUDA="${CUDA_ON_OFF}" \
          -D WITH_CUBLAS="${CUDA_ON_OFF}" \
          -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.0 \
          -D CUDA_FAST_MATH="${CUDA_ON_OFF}" \
          -D ENABLE_FAST_MATH="${CUDA_ON_OFF}" \
          -D OPENCV_ENABLE_NONFREE=ON \
          -D WITH_GTK=OFF \
          -D WITH_OPENGL=ON \
          -D WITH_OPENVX=ON \
          -D WITH_OPENCL=ON \
          -D WITH_TBB=ON \
          -D WITH_EIGEN=ON \
          -D WITH_GDAL=ON \
          -D WITH_FFMPEG=ON \
          -D BUILD_TIFF=ON \
          -D BUILD_opencv_python2=OFF \
          -D BUILD_opencv_python3=ON \
          -D PYTHON_DEFAULT_EXECUTABLE="${py3_exec}" \
          -D PYTHON3_EXECUTABLE="${py3_exec}" \
          -D PYTHON3_INCLUDE_DIR="${py3_include}" \
          -D PYTHON3_PACKAGES_PATH="${py3_packages}" \
          -D PYTHON3_LIBRARY="${py3_config}" \
          -D PYTHON3_NUMPY_INCLUDE_DIRS="${py3_numpy}" \
          -D INSTALL_PYTHON_EXAMPLES=OFF \
          -D INSTALL_C_EXAMPLES=OFF \
          -D BUILD_EXAMPLES=OFF \
          -D CMAKE_CXX_STANDARD=14 ..

    make -j"$(nproc)"
    make -j"$(nproc)" install
    ldconfig # Refresh shared library cache
}

# Cleanup
###########################################################
cleanup() {
    print yellow frame "Cleanup - removing temporary files\n"
    cd ${WORKING_DIR}

    rm opencv.tar.gz
    rm opencv_contrib.tar.gz
    rm -r opencv-${OPENCV_VERSION}
    rm -r opencv_contrib-${OPENCV_VERSION}
}

# MAIN FUNCTION
###########################################################
install_dependencies
install_opencv
cleanup

print green frame "Opencv ${OPENCV_VERSION} installation was successful\n"