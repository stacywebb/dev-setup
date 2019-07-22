# devsetup for Raspberry Pi

This tutorial describes the console-based Raspberry Pi set up.

If you are using the Raspberry Pi with Desktop, then you can use the graphical configuration application from the preferences menu to configure your Raspberry Pi.

## Download Raspberry Pi OS image

Official images for recommended operating systems are available to download from the Raspberry Pi website [Downloads page](https://www.raspberrypi.org/downloads).

For this tutorial, I am using the [Raspbian Buster Lite](https://downloads.raspberrypi.org/raspbian_lite_latest) image.

## Writing an image to the SD card

Before you start, don't forget to check the SD [card requirements](https://www.raspberrypi.org/documentation/installation/sd-cards.md).

You will need to use an image writing tool to install the image you have downloaded on your SD card.

**balenaEtcher** is a graphical SD card writing tool that works on Mac OS, Linux and Windows, and is the easiest option for most users. balenaEtcher also supports writing images directly from the zip file, without any unzipping required. To write your image with balenaEtcher:

* Download [balenaEtcher](https://www.balena.io/etcher/) and install it.
* Connect an SD card reader with the SD card inside.
* Open balenaEtcher and select from your hard drive the Raspberry Pi `.img` or `.zip` file you wish to write to the SD card.
* Select the SD card you wish to write your image to.
* Review your selections and click 'Flash!' to begin writing data to the SD card.

For more advanced control of this process, see the system-specific guides:

* [Linux](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)
* [Mac OS](https://www.raspberrypi.org/documentation/installation/installing-images/mac.md)
* [Windows](https://www.raspberrypi.org/documentation/installation/installing-images/windows.md)

## Enable SSH when creating an SD card

SSH is disabled by default (check [Raspberry Pi release notes](http://downloads.raspberrypi.org/raspbian/release_notes.txt)). It can be enabled by creating a file with name `ssh` in boot partition.

To enable SSH connection, paste at a terminal prompt:

```bash
# /Volumes/boot/ => Path/to/SD_card
touch /Volumes/boot/ssh
```

## Set up the WiFi when creating an SD card

In boot partition, create a `wpa_supplicant.conf` file with the content below.

Copy and paste the block of commands replacing `ssid`, `psk`, and `country` with your informations:

```bash
read -r -d '' WPA <<"EOF"
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

# Allow wpa_supplicant to update (overwrite) configuration
update_config=1

# ISO two-letter country code
country=FR

network={
    ssid="YOUR-SSID"
    psk="YOUR-PASSWORD"
    scan_ssid=1
}
EOF

# Create the wpa_supplicant.conf file
# /Volumes/boot/ => Path/to/SD_card
echo "${WPA}" > /Volumes/boot/wpa_supplicant.conf
```

* `ssid` and `psk`: your network's settings
* `country`: [ISO two-letter country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). Common codes include:
  * GB (United Kingdom)
  * FR (France)
  * DE (Germany)
  * US (United States)
  * SE (Sweden)

## Connecting to the Raspberry Pi

Next, insert the SD card into your Raspberry Pi and boot the device.

Give that a minute or so to complete then try pinging the device to locate it:

```bash
ping raspberrypi.local
```

You can ssh into the device using:

```bash
ssh pi@raspberrypi.local
```

The default password is `raspberry`

If you encounter the following error:

```bash
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@       WARNING: POSSIBLE DNS SPOOFING DETECTED!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

Then simply edit your `.ssh/known_hosts` file and remove the line that has the raspberrypi entry:

```bash
nano /Users/${USER}/.ssh/known_hosts
```

## Configuring the Raspberry Pi

Setup your timezone:

```bash
sudo dpkg-reconfigure tzdata
```

Make sure the OS is up to date:

```bash
sudo apt-get update
sudo apt-get upgrade
```

You can optionally proceed to make other tweaks using the `raspi-config`:

```bash
sudo raspi-config
```

## Expand filesystem on the Raspberry Pi

Expand the Raspberry Pi filesystem to include all available space on teh SD card:

```bash
 sudo raspi-config
```

And then select the "Advanced Options" menu item:

![Raspberry Pi - advanced options](raspi-advanced-options.png?raw=true)

Followed by selecting "Expand filesystem":

![Raspberry Pi - expand filesystem](raspi-expand-filesystem.png?raw=true)

Once prompted, you should select the first option, "A1. Expand File System" and hit `Enter` on your keyboard.

Then, arrow down to the `<Finish>` button, and then reboot the Raspberry Pi. You may be prompted to reboot, but if you aren't you can execute:

```bash
sudo reboot
```

After rebooting, the file system should have been expanded to include all available space on the SD card.

Verify if the disk has been expanded by executing `df -h` and examining the output:

```bash
pi@raspberrypi:~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        29G  1.2G   27G   5% /
devtmpfs        459M     0  459M   0% /dev
tmpfs           464M     0  464M   0% /dev/shm
tmpfs           464M  6.2M  457M   2% /run
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           464M     0  464M   0% /sys/fs/cgroup
/dev/mmcblk0p1  253M   40M  213M  16% /boot
tmpfs            93M     0   93M   0% /run/user/1000
```

As you can see, my Raspbian filesystem has been expanded to include all 32GB of the SD card.

However, even with my filesystem expanded, I have already used 5% of my 32GB card.

## Perl warning setting locale failed on Raspbian

You can fix the issue by setting the locale to `en_US.UTF-8`, `en_GB.UTF-8`, or `en_FR.UTF-8` for example:

```bash
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales
```

## Installing Python libraries

Install dependencies:

```bash
sudo apt-get install --no-install-recommends \
    python3-pip
```

Install Python libraries:

```bash
# Upgrade Pip
sudo pip3 install --upgrade pip

# Basic libraries
sudo pip3 install \
    progressbar2 \
    requests \
    Cython \
    pylint \
    autopep8 \
    pytest \
    pydocstyle
```

Make use of virtual environments for Python development.

If you aren't familiar with virtual environments, check out [this article on RealPython](https://realpython.com/python-virtual-environments-a-primer/).

```bash
# Virtual environments
sudo pip3 install \
    virtualenv \
    virtualenvwrapper
```

To finish, we need to update the `~/.profile` file (similar to `.bashrc` or `.bash_profile`).

Copy and paste the following commands:

```bash
read -r -d '' PROFILE <<"EOF"
# virtualenv and virtualenvwrapper
export WORKON_HOME=${HOME}/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
EOF

# Create the ~/.profile file
echo "${PROFILE}" >> ${HOME}/.profile

# Update the terminal
source ${HOME}/.profile
```

## Installing OpenCV using Pip (not ready for Raspbian Buster 2019-07-10)

If you are looking for an easy and fast way to install OpenCV, use Pip - Python's package manager.

[Dave Jones](https://github.com/waveform80) (creator of the Picamera Python module) and [Ben Nuttall](https://github.com/bennuttall) (Raspberry Pi community) run [piwheels.org](https://www.piwheels.org), a Python package repository providing pre-compiled binaries packages for the Raspberry Pi.

There are four OpenCV packages that are pip-installable on the PyPI repository:

1. [opencv-python](https://pypi.org/project/opencv-python/): this repository contains just the main modules of the OpenCV library.
2. [opencv-contrib-python](https://pypi.org/project/opencv-contrib-python/): this repository contains both the main modules along with the contrib modules.
3. [opencv-python-headless](https://pypi.org/project/opencv-python-headless/): same as opencv-python but no GUI functionality. Useful for headless systems.
4. [opencv-contrib-python-headless](https://pypi.org/project/opencv-contrib-python-headless/): same as opencv-contrib-python but no GUI functionality. Useful for headless systems.

You DO NOT need to install both `opencv-python` and `opencv-contrib-python` — just pick one of them.

The PyPi/PiWheels hosted versions of OpenCV DO NOT include "non-free" algorithms such as SIFT, SURF, and other patented algorithms. If you need non-free algorithms, you need to compile and install OpenCV from source.

Install Raspberry Pi OpenCV dependencies:

```bash
sudo apt-get install \
    libhdf5-dev libhdf5-serial-dev libhdf5-100 \
    libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 \
    libatlas-base-dev \
    libjasper-dev
```

Create a virtual environment to hold OpenCV 4 and additional packages:

```bash
mkvirtualenv py37pipcv4 -p python3
```

Install OpenCV:

```bash
# Activate Python environment
workon py37pipcv4

# Install numpy
pip install numpy

# Install OpenCV Headless for Raspbian Lite
pip install opencv-contrib-python-headless
```

## Installing OpenCV 4

1. INSTALLING dependencies

    Let's update the system:

    ```bash
    sudo apt-get update && sudo apt-get upgrade
    ```

    Install developer tools including [CMake](https://cmake.org):

    ```bash
    sudo apt-get install build-essential cmake unzip pkg-config
    ```

    Install a selection of image and video libraries:

    ```bash
    sudo apt-get install libjpeg-dev libpng-dev libtiff-dev \
        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
        libxvidcore-dev libx264-dev
    ```

    Install GTK, a GUI backend (only if you have a Raspbian with Desktop):

    ```bash
    sudo apt-get install libgtk-3-dev
    sudo apt-get install libcanberra-gtk*
    ```

    Install two packages for numerical optimizations:

    ```bash
    sudo apt-get install libatlas-base-dev gfortran
    ```

    Install the Python 3 development headers:

    ```bash
    sudo apt-get install python3-dev
    ```

    Create and activate a Python environment:

    ```bash
    mkvirtualenv py37cv4
    ```

    And finally, install numpy:

    ```bash
    pip install numpy
    ```

2. DOWNLOADING OpenCV files

    Copy and paste the following commands:

    ```bash
    OPENCV_VERSION="4.1.0"
    OPENCV_URL="https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz"
    OPENCV_CONTRIB_URL="https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz"
    ```

    ```bash
    cd ${HOME}

    curl -L ${OPENCV_URL} -o "opencv.tar.gz"
    curl -L ${OPENCV_CONTRIB_URL} -o "opencv_contrib.tar.gz"

    tar -xzf opencv.tar.gz
    tar -xzf opencv_contrib.tar.gz

    mkdir -p opencv-${OPENCV_VERSION}/build
    cd opencv-${OPENCV_VERSION}/build
    ```

3. CONFIGURING OpenCV installation

    ```bash
    # Configure OpenCV via CMake
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH="../../opencv_contrib-${OPENCV_VERSION}/modules" \
          -D ENABLE_NEON=ON \
          -D ENABLE_VFPV3=ON \
          -D BUILD_TESTS=OFF \
          -D OPENCV_ENABLE_NONFREE=ON \
          -D INSTALL_PYTHON_EXAMPLES=OFF \
          -D BUILD_EXAMPLES=OFF ..
    ```

    Check if the interpreter points to the correct Python 3 binary, and if numpy points to the NumPy package installed inside the virtual environment.

    * `-D OPENCV_ENABLE_NONFREE=ON`  flag ensures that you'll have access to SIFT/SURF and other non-free algorithms.
    * [NEON](https://developer.arm.com/architectures/instruction-sets/simd-isas/neon) is an optimization architecture extension for ARM processors designed specifically for faster video processing, image processing, speech recognition, and machine learning.
    * [VFPv3](https://developer.arm.com/architectures/instruction-sets/floating-point) is the name for ARM's Vector Floating Poing (VFP) version 3.

4. Increase the SWAP on the Raspberry Pi

    Before the compile process, it is recommended to increase the swap space. More swap space enables to compile OpenCV with all four cores of the Raspberry Pi without having problems due to full memory.

    Edit and restart the swap service:

    ```bash
    sudo sed -i 's/#CONF_SWAPSIZE=100/CONF_SWAPSIZE=2048/g' /etc/dphys-swapfile
    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start
    ```

5. Make & make install

    ```bash
    make -j4
    ```

    ```bash
    sudo make -j4 install
    ```

    ```bash
    sudo ldconfig
    ```

6. Reset the SWAP on the Raspberry Pi

    Remember to go back and reset the swap size:

    ```bash
    sudo sed -i 's/CONF_SWAPSIZE=2048/#CONF_SWAPSIZE=100/g' /etc/dphys-swapfile
    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start
    ```

    We enabled a large swap only to compile OpenCV. It is not prudent to keep a large swap size for a long time. Increasing swap size is a great way to burn out your SD card. Flash-based storage have limited number of writes you can perform until the card is essentially unable to keep the recorded data.

7. Sym-link OpenCV to your virtual environment

    Copy and paste the following commands on your terminal:

    ```bash
    # Get the OpenCV library path
    opencv_lib="$(ls /usr/local/lib/python3.*/site-packages/cv2/python-3.*/cv2.*.so)"

    # Activate py37cv4 Python environment
    workon py37cv4

    # Get the site-packages path of the virtual environment
    site_packages="$(python3 -c "import distutils.sysconfig as s; print(s.get_python_lib())")"

    # Create a link to OpenCV library
    ln -s ${opencv_lib} ${site_packages}
    ```

8. Test installation with Python

    ```bash
    # Check if the OpenCV library is well configured
    python -c "import cv2;  print(cv2.__version__)"
    # The output should be 4.1.0
    ```

## References

[1] Adrian Rosebrock. [OpenCV Tutorials, Resources, and Guides](https://www.pyimagesearch.com/opencv-tutorials-resources-guides/). PyImageSearch.

[2] Adrian Rosebrock. [Install OpenCV 4 on your Raspberry Pi](https://www.pyimagesearch.com/2018/09/26/install-opencv-4-on-your-raspberry-pi/). PyImageSearch, September 26, 2018.

[3] Adrian Rosebrock. [Pip install opencv](https://www.pyimagesearch.com/2018/09/19/pip-install-opencv/). PyImageSearch. September 19, 2018.

[4] Ben Nuttall. [New opencv builds](https://blog.piwheels.org/new-opencv-builds/). Piwheels. September 27, 2018.

[5] Sagi Zeevi. [Build a faster OpenCV for Raspberry Pi3](https://www.theimpossiblecode.com/blog/build-faster-opencv-raspberry-pi3/). October 30, 2017.

[6] Scott Robinson. [Python Virtual Environments: A Primer](https://realpython.com/python-virtual-environments-a-primer/). Real Python. December 01, 2018.

[7] Shane Pfaffly. [How to change Raspberry Pi's Swapfile Size on Raspbian](https://www.bitpi.co/2015/02/11/how-to-change-raspberry-pis-swapfile-size-on-rasbian/). BitPi.co . February 11, 2015.

[8] Raspberry Pi. [Setting up your Raspberry Pi](https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up).
