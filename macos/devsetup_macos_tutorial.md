# devsetup for macOS

This tutorial explains in detail the setup process for macOS.

To make your life easier, [install devsetup for macOS](https://github.com/marcosgomesborges/dev-setup#install-devsetup-for-macos).

## Installing GCC

The first thing we need to install is the [GNU Compiler Collection (GCC)](https://www.gnu.org/software/gcc/).

1. Open the terminal and run the following command:

    ```bash
    # Install the Apple Command Line Tools package
    xcode-select --install
    ```

2. Install the additional SDK headers:

    ```bash
    sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
    ```

## Installing Homebrew

[Homebrew](https://brew.sh) is the missing package manager for macOS.

1. Open the terminal and run the following script:

    ```bash
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

## Installing Git

[Git](https://git-scm.com) is a free and open source distributed version control system.

1. Install Git:

    ```bash
    brew install git
    ```

2. Configure Git:

    ```bash
    # User name and email
    git config --global user.name "Your name"
    git config --global user.email "your@email.com"
    ```

    ```bash
    # Tells git that we want color in our UI
    git config --global color.ui true
    git config --global color.status.changed "blue normal"
    git config --global color.status.untracked "red normal"
    git config --global color.status.added "magenta normal"
    git config --global color.status.updated "green normal"
    git config --global color.status.branch "yellow normal bold"
    git config --global color.status.header "white normal bold"
    ```

## Updating bash

1. Update bash:

    ```bash
    brew install bash
    ```

2. Add the new shell to the list of allowed shells:

    ```bash
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    ```

3. Change to the new shell:

    ```bash
    chsh -s /usr/local/bin/bash
    ```

4. Check the bash version:

    ```bash
    bash --version
    # GNU bash, version 4.4.23(1)-release
    ```

5. Install bash TAB completion 2:

    ```bash
    brew install bash-completion@2
    ```

6. Install Informative git-prompt:

    ```bash
    brew install bash-git-prompt
    ```

7. Install Docker bash TAB complete:

   * Docker-machine tab complete:

    ```bash
    sudo curl -L https://raw.githubusercontent.com/docker/machine/v0.16.0/contrib/completion/bash/docker-machine.bash \
    -o /usr/local/etc/bash_completion.d/docker-machine
    ```

   * Docker-compose tab complete:

    ```bash
    sudo curl -L https://raw.githubusercontent.com/docker/compose/1.23.1/contrib/completion/bash/docker-compose \
    -o /usr/local/etc/bash_completion.d/docker-compose
    ```

## Update the .bash_profile file and terminal theme

This is the terminal using my personal theme and `.bash_profile` configuration. Feel free to copy and use it.

![Gomes-Borges macOS terminal](./gomes_borges_terminal.png?raw=true)

1. Download and open the [macOS.terminal](https://github.com/marcosgomesborges/dev-setup/blob/master/macos/macOS.terminal) file.

2. Once the terminal is open, set the theme as default:
   * Select `Terminal` menu then `Preferences`
   * Select the `Profiles` Tab
   * Click and highlight the `macOS` themes
   * Press the `Default` button near the bottom of the window

3. Update the .bash_profile file using the following commands:

    * Backup the current ~/.bash_profile

      ```bash
      if [[ -f ~/.bash_profile ]]; then
          cp ~/.bash_profile ~/.bash_profile.bkp
      fi
      ```

    * Update the .bash_profile copying and pasting the following script:

      ```bash
      read -r -d '' BASH_PROFILE <<"EOF"
      # !/bin/bash
      ###########################################################
      # Bash Profile
      #
      # Copyright (c) Marcos Gomes-Borges
      ###########################################################

      # LS Colors
      # CLICOLOR use ANSI color sequences to distinguish file types
      export CLICOLOR=true
      export LSCOLORS=gxegbxdxcxahadabafacge
      alias ls='ls -GFh'

      # COLORS \e[<prefix>;<color>m;<decoration> http://jonasjacek.github.io/colors
      TEAL="\[\e[38;5;6m\]\]"
      YELLOW="\[\e[38;5;11m\]"
      MAGENTA="\[\e[38;5;13m\]"
      WHITE="\[\e[38;5;15m\]"
      GREEN="\[\e[38;5;40m\]"
      NONE="\[\e[0m\]"

      # Prevent Mac OS ._ in in tar.gz files
      export COPYFILE_DISABLE=true

      # Homebrew
      export PATH="/usr/local/bin:${PATH}"

      # Homebrew completion
      if [ -f $(brew --prefix)/etc/bash_completion.d/brew ]; then
          . $(brew --prefix)/etc/bash_completion.d/brew
      fi

      # Bash completion@2
      if [ -f /usr/local/share/bash-completion/bash_completion ]; then
      . /usr/local/share/bash-completion/bash_completion
      fi

      # Bash-Git-prompt
      if [ -f $(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh ]; then
          __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share

          GIT_PS1_SHOWCOLORHINTS=true
          GIT_PS1_SHOWDIRTYSTATE=true
          GIT_PS1_SHOWUNTRACKEDFILES=true
          GIT_PS1_DESCRIBE_STYLE='default'

          source $(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh
      fi

      # Python virtual environment
      # Allow pip only for active virtual environment
      # Use `gpip` or `gpip3` for global environment
      export PIP_REQUIRE_VIRTUALENV=true
      gpip(){
          PIP_REQUIRE_VIRTUALENV="" pip "${@}"
      }
      gpip3(){
          PIP_REQUIRE_VIRTUALENV="" pip3 "${@}"
      }

      # Pyenv Python version management
      if command -v pyenv 1>/dev/null 2>&1; then
          eval "$(pyenv init -)"
          pyenv virtualenvwrapper
      fi

      # PRIMARY PROMPT
      PROMPT_COMMAND='__git_ps1\
                      "\n${MAGENTA}[\d \t] ${YELLOW}`(python --version 2>&1)`${NONE}\
                      \n${GREEN}\u@\h:${TEAL}\w${NONE}"\
                      "\n${VIRTUAL_ENV:+(`basename ${VIRTUAL_ENV}`)}\\$ "\
                      " (%s)"'
      EOF


      echo "${BASH_PROFILE}" > ${HOME}/.bash_profile
      ```

## Improve command line history search

On the the terminal application, copy and paste the following commands:

```bash
read -r -d '' INPUTRC <<"EOF"
"\e[A":history-search-backward
"\e[B":history-search-forward

set colored-stats on
set mark-symlinked-directories on
set show-all-if-ambiguous on
set show-all-if-unmodified on
set visible-stats on
set completion-ignore-case on
TAB: menu-complete
EOF

echo "${INPUTRC}" > ${HOME}/.inputrc
```

## Installing multiple Python versions

[Pyenv](https://github.com/pyenv/pyenv) lets you easily switch between multiple versions of Python. It's simple.

1. Install pyenv:

    ```bash
    brew install pyenv
    ```

2. Install pyenv-virtualenvwrapper :

    ```bash
    brew install pyenv-virtualenvwrapper
    ```

3. Install a few different versions of Python:

    ```bash
    # Init Pyenv
    eval "$(pyenv init -)"

    # Install Python
    PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 2.7.15
    PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.6.5
    PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.7.3
    ```

4. Set the Python version you want as default:

    ```bash
    pyenv global 3.6.5
    ```

5. Setup the virtualenvwrapper:

    ```bash
    pyenv virtualenvwrapper
    ```

## Installing Python libraries

1. Install dependencies:

    ```bash
    # Leave Python virtual environment
    deactivate

    # Install Graphviz - Keras dependency
    brew install Graphviz
    ```

2. Create a Python virtual environment:

    ```bash
     # Set Python 3.6.5
     pyenv shell 3.6.5
     mkvirtualenv py365
     pip install --upgrade pip
    ```

    > Remember to activate Python environment using **workon py365**

3. Installing TensorFlow:

    Check the TensorFlow documentation for more details <https://www.tensorflow.org/install>.

    ```bash
    pip install tensorflow
    ```

4. Install Keras:

    ```bash
    pip install h5py \
                pydot \
                keras
    ```

5. Install scientific libraires:

    ```bash
    pip install numpy \
                pandas \
                scipy \
                pillow \
                scikit-learn \
                scikit-image \
                sk-video
    ```

6. Install basic libraires:

    ```bash
    pip install progressbar2 \
                requests \
                Cython \
                pylint \
                autopep8 \
                pytest \
                pydocstyle
    ```

7. Install Matplotlib:

    ```bash
    pip install ipympl matplotlib

    # Fix Matplotlib backend
    mkdir -p ~/.config/matplotlib
    echo "backend : TkAgg" > ~/.config/matplotlib/matplotlibrc
    ```

8. Install Jupyter lab:

    ```bash
    # Leave Python virtual environment
    deactivate

    # Install Node
    brew install node

    # Activate Python environment
    workon py365

    # Install Jupyterlab
    pip install jupyterlab jupyterlab-git

    jupyter labextension install @jupyterlab/toc
    jupyter labextension install @jupyterlab/git
    jupyter serverextension enable --py jupyterlab_git

    jupyter labextension install @jupyter-widgets/jupyterlab-manager
    jupyter labextension install jupyter-matplotlib
    ```

## Installing FFmpeg

[FFmpeg](https://ffmpeg.org/documentation.html) is the leading multimedia framework, able to decode, encode, transcode, mux, demux, stream, filter and play pretty much anything that humans and machines have created.

```bash
# Leave Python virtual environment
deactivate

# Install FFmpeg with all modules
brew install ffmpeg $(brew options ffmpeg | grep -E '^--with-' - | tr '\n' ' ')
```

## Installing OpenCV 4

Copy and past the following commands:

1. Download, configure and install Opencv

    ```bash
    DEVSETUP_PREFIX="/usr/local"
    OPENCV_VERSION="4.1.0"
    OPENCV_URL="https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz"
    OPENCV_CONTRIB_URL="https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz"

    # Leave Python virtual environment
    deactivate

    # Installing Opencv dependencies
    brew install cmake pkg-config jpeg webp gphoto2 libpng libtiff openexr eigen tbb

    # Activate Python environment
    workon py365

    pip install pip numpy
    ```

2. DOWNLOADING OpenCV files

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
    # Automatically ENABLE/DISABLE Qt
    if ls ${HOME}/Qt*/*/clang_64/bin/qmake 1>/dev/null 2>&1; then
        QT_ON_OFF=ON
    else
        QT_ON_OFF=OFF
    fi

    QT_LIB=`echo ${HOME}/Qt*/*/clang_64/lib/cmake`
    QT_QMAKE=`echo ${HOME}/Qt*/*/clang_64/bin/qmake`
    ```

    ```bash
    # Get PATH for Python libraries
    py3_exec=`which python3`
    py3_config=`python3 -c "from distutils.sysconfig import get_config_var as s; print(s('LIBDIR'))"`
    py3_version=`python3 -c "from sys import version_info as s; print('{}.{}'.format(s.major, s.minor))"`
    py3_include=`python3 -c "import distutils.sysconfig as s; print(s.get_python_inc())"`
    py3_packages=`python3 -c "import distutils.sysconfig as s; print(s.get_python_lib())"`
    py3_numpy=`python3 -c "import numpy; print(numpy.get_include())"`
    ```

    ```bash
    # Configure OpenCV via CMake
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VERSION}/modules \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D WITH_CUDA=OFF \
    -D WITH_QT=${QT_ON_OFF} \
    -D CMAKE_PREFIX_PATH=${QT_LIB} \
    -D QT_QMAKE_EXECUTABLE=${QT_QMAKE} \
    -D QT5Core_DIR=${QT_LIB}/Qt5Core \
    -D QT5Gui_DIR=${QT_LIB}/Qt5Gui \
    -D QT5Test_DIR=${QT_LIB}/Qt5Test \
    -D QT5Widgets_DIR=${QT_LIB}/Qt5Widgets \
    -D Qt5Concurrent_DIR=${QT_LIB}/Qt5Concurrent \
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
    -D PYTHON_DEFAULT_EXECUTABLE=${py3_exec} \
    -D PYTHON3_EXECUTABLE=${py3_exec} \
    -D PYTHON3_INCLUDE_DIR=${py3_include} \
    -D PYTHON3_PACKAGES_PATH=${py3_packages} \
    -D PYTHON3_LIBRARY=${py3_config} \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=${py3_numpy} \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D BUILD_EXAMPLES=ON \
    -D CMAKE_CXX_STANDARD=14 ..
    ```

4. Make & make install

    ```bash
    make -j"$(nproc)"

    sudo make -j"$(nproc)" install
    ```

5. Test installation with Python

    ```bash
    # Activate Python environment
    workon py365

    # Check if the OpenCV library is well configured
    python -c "import cv2;  print(cv2.__version__)"
    # The output should be 4.1.0
    ```

6. Test installation with C++

    We can run some sample code located at `opencv/samples/cpp`:

    ```bash
    # Access CPP examples
    cd ${HOME}/opencv-${OPENCV_VERSION}/samples/cpp

    # Active OpenCV virtual environment
    workon opencv

    # Compile and run without CUDA support
    g++ -ggdb `pkg-config --cflags --libs opencv` facedetect.cpp -o /tmp/test && /tmp/test
    ```

7. Test installation with Qt

    * The very first thing to do is instruct Qt where to find pkg-config

      ```bash
      which pkg-config
      # returns /usr/local/bin/pkg-config
      ```

    * We need to add `/usr/local/bin` to PATH

      Go to **Project**, expand **Build Environment** and add `/usr/local/bin` to PATH.

      Don’t forget to add a colon ":" before appending /usr/local/bin (see the screenshot below).

      ![Qt build settings for OpenCV](./qt_path.png?raw=true)

    * You also need to add a new variable called `PKG_CONFIG_PATH` and set it to the directory that contains opencv.pc for your OpenCV 3 installation. You can find it using the following command:

      ```bash
      find /usr/local -name "opencv.pc"
      # /usr/local/lib/pkgconfig/opencv.pc
      ```

    * Now that the paths are correctly set up, we need to add a few lines to our project file `.pro` to tell qmake to use pkg-config for OpenCV:

      ```bash
      # Tells Qmake to use pkg-config for OpenCV
      QT_CONFIG -= no-pkg-config
      CONFIG += link_pkgconfig
      PKGCONFIG += opencv

      # Add OpenCV Libraries
      LIBS += `pkg-config --libs opencv`
      ```

    * You may receive a runtime error on macOS High Sierra. Note the actual error message may vary sometimes:

      ```bash
      dyld: Symbol not found: __cg_jpeg_resync_to_restart
      Referenced from: /System/Library/Frameworks/ImageIO.framework/Versions/A/ImageIO
      Expected in: /usr/local/lib/libJPEG.dylib
      in /System/Library/Frameworks/ImageIO.framework/Versions/A/ImageIO
      The program has unexpectedly finished.
      ```

      __To fix it__ go to Project -> Run -> Run Environment -> Unset DYLD_LIBRARY_PATH. See image below:

      ![DYLD problem](./qt_dyld.png?raw=true)

8. Sym-link OpenCV to your virtual environment (if necessary)

    Copy and paste the following commands on your terminal:

    ```bash
    # Get the OpenCV library path
    opencv_lib="${HOME}/opencv/build/lib/python3/*.so"

    # Activate TARGET Python environment
    workon TARGET_ENV

    # Get the site-packages path of the virtual environment
    site_packages=`python3 -c "import distutils.sysconfig as s; print(s.get_python_lib())"`

    # Create a link to OpenCV library
    ln -s ${opencv_lib} ${site_packages}
    ```
