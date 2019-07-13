#!/bin/bash
###########################################################
# INSTALL FFMPEG ON UBUNTU GNU/LINUX
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

# Install settings
###########################################################
FFMPEG_VERSION=4.1.3
FFMPEG_URL="https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.xz"
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

# Install FFmpeg dependencies
###########################################################
install_dependencies() {
    print yellow frame "Installing FFmpeg dependencies\n"
    apt-get update --quiet

    apt-get install --yes --quiet --no-install-recommends \
        autoconf automake build-essential ca-certificates cmake git libtool wget

    apt-get install --yes --quiet --no-install-recommends \
        nasm yasm libass-dev libmp3lame-dev libopus-dev libtheora-dev \
        libvorbis-dev libx264-dev libx265-dev libopenal-data libopenal1 \
        libopenal-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev \
        tesseract-ocr libtesseract-dev tesseract-ocr-eng tesseract-ocr-fra \
        libleptonica-dev libfdk-aac-dev libvpx-dev
}

# Install NVIDIA Video Codec SDK - NVDEC/NVCUVID API
###########################################################
install_nvidia_nvdec() {
    print yellow "Installing NVIDIA Video Codec SDK\n"

    if [ -d "nv-codec-headers" ]; then
        rm -r nv-codec-headers
    fi

    git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git

    cd nv-codec-headers
    make
    make install
    cd ${WORKING_DIR}

# Define NVIDIA GPU options to configure FFmpeg
read -d '' ENABLE_CUDA <<EOF
    --extra-cflags=-I/usr/local/cuda/include \
    --extra-ldflags=-L/usr/local/cuda/lib64 \
    --enable-cuda \
    --enable-cuvid \
    --enable-libnpp \
    --enable-nvenc
EOF
}

# Download, configure and install FFmpeg
###########################################################
install_ffmpeg() {
    # Check GPU support
    if [ $(nvidia_gpu_available) != 0 ]; then
        print green frame "NVIDIA GPU detected\n"
        install_nvidia_nvdec
    else
        print red frame "NVIDIA GPU NOT detected\n"
        ENABLE_CUDA=""
    fi

    set -e # Exit immediately if the pipeline fail

    # Download, configure and install FFmpeg
    print yellow frame "Downloading, configuring and installing FFmpeg\n"
    wget -N ${FFMPEG_URL}
    tar -xJf ffmpeg-${FFMPEG_VERSION}.tar.xz
    cd ffmpeg-${FFMPEG_VERSION}

    ./configure \
        ${ENABLE_CUDA} \
        --prefix=/usr \
        --enable-shared \
        --enable-small \
        --enable-version3 \
        --disable-doc \
        --disable-manpages \
        --disable-podpages \
        --enable-gpl \
        --enable-libass \
        --enable-libfdk-aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libtesseract \
        --enable-libtheora \
        --enable-libvorbis \
        --enable-libx264 \
        --enable-libx265 \
        --enable-nonfree \
        --enable-openal \
        --enable-opengl \
        --enable-pthreads

    make -j"$(nproc)"
    make -j"$(nproc)" install
    ldconfig # Refresh shared library cache
}

# Cleanup
###########################################################
cleanup() {
    print yellow frame "Cleanup - removing temporary files\n"
    cd ${WORKING_DIR}
    rm -rf nv-codec-headers
    rm ffmpeg-${FFMPEG_VERSION}.tar.xz
    rm -rf ffmpeg-${FFMPEG_VERSION}
}

# MAIN FUNCTION
###########################################################
install_dependencies
install_ffmpeg
cleanup

print green frame "FFmpeg ${FFMPEG_VERSION} installation was successful\n"