# Development Environment Setup

Setting up a new development environment can be a manual and time-consuming process. This project aims to simplify the process with easy instructions and scripts to automate the setup of the following:

* GNU/Linux
* macOS - [see the tutorial page](https://github.com/marcosgomesborges/dev-setup/blob/master/macos/devsetup_macos_tutorial.md)
* Windows
* Docker
* Raspberry Pi - [see the tutorial page](https://github.com/marcosgomesborges/dev-setup/blob/master/raspberrypi/devsetup_raspberrypi_tutorial.md)

## devsetup essential commands

The basic devsetup command takes this form: `devsetup <command>`

| Command           | Description                                       |
| ---               | ---                                               |
| `-h, --help`      | print the help message                            |
| `-v, --version`   | print the version number of devsetup              |
| `-i, --install`   | install a package                                 |
| `-u, --update`    | update a package                                  |

## Install devsetup for macOS

To install devsetup for macOS to `/usr/local`, paste at a terminal prompt:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/marcosgomesborges/dev-setup/master/install_macos)
```

My personal theme for Terminal.app `macOS.terminal` is available inside the `macos` folder!

![macOS terminal](./macos/macos_terminal.gif?raw=true)

### macOS Packages

To install a package: `devsetup --install <package>`

| macOS Package         | Description                                                                   |
| ---                   | ---                                                                           |
| `homebrew`            | Install Hombrew and its dependencies: GCC and Command Line Tools with Headers |
| `git`                 | Install and setup git                                                         |
| `bash`                | Install the latest version of Bash                                            |
| `bash-tab-completion` | Install bash tab completion 2, git-prompt, and docker tab completion          |
| `pyenv`               | Install multiple Python versions using 'pyenv': Python 2.7.15, 3.6.5, 3.7.3   |
| `pylibs`              | Install Python Libraries: TensorFlow, Keras, scientific libraires             |
| `jupyterlab`          | Install Jupyterlab with extensions: toc, git, matplotlib                      |
| `ffmpeg`              | Install FFmpeg with all modules                                               |
| `opencv`              | Install OpenCV 4.1.0                                                          |
| `all`                 | Install all the packages                                                      |

### macOS update functions

To update a package or configuration: `devsetup --update <package>`

| macOS Package     | Description                                                                           s|
| ---               | ---                                                                                   |
| `devsetup`        | Update devsetup script (download the latest version)                                  |
| `git`             | Set-up git with username, email, and terminal colors                                  |
| `bash-profile`    | Set-up bash_profile                                                                   |
| `inputrc`         | Improve command line history search                                                   |
| `vscode`          | Setup Visual Studio Code and install extensions (check `macos/vs-code-settings.json`) |

## Install devsetup for GNU/Linux

To install devsetup for GNU/Linux to `/usr/local`, paste at a terminal prompt:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/marcosgomesborges/dev-setup/master/install_linux)
```

### GNU/Linux Packages

To install a package: `devsetup --install <package>`

| GNU/Linux Package | Description                                                                   |
| ---               | ---                                                                           |
| `ToDo`            | Coming soon!                                                                  |

## Docker devsetup

Building an app, installing the dependencies and services, automating the deployment, and more — it all starts with the Dockerfile.

Check out my [Dockerfile examples](https://github.com/marcosgomesborges/dev-setup/tree/master/docker). Naturally, you’ll have to adapt the Dockerfile to your needs, but hopefully you get the idea of the possibilities.

You will find examples to configure and install the following softwares:

| Docker Package        | Description                                                                   |
| ---                   | ---                                                                           |
| `bash`                | Install the latest version of Bash                                            |
| `bash-tab-completion` | Install bash tab completion 2, git-prompt, and docker tab completion          |
| `pylibs`              | Install Python Libraries: TensorFlow, Keras, scientific libraires             |
| `jupyterlab`          | Install Jupyterlab with extensions: toc, git, matplotlib                      |
| `ffmpeg`              | Install FFmpeg with all modules                                               |
| `opencv`              | Install OpenCV 4.1.0                                                          |

### More Dockerfile examples

* [NVIDIA CUDA and cuDNN](https://hub.docker.com/r/nvidia/cuda)
* [TensorFlow Dockerfiles](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/dockerfiles)

## Raspberry Pi

Check out my tutorial [devsetup for Raspberry Pi](https://github.com/marcosgomesborges/dev-setup/blob/master/raspberrypi/devsetup_raspberrypi_tutorial.md).

You will find examples to configure and install the following items:

| Raspberry Pi Package  | Description                |
| ---                   | ---                        |
| `SSH`                 | Enable the SSH access      |
| `WiFi`                | Set up the WiFi connection |
| `pylibs`              | Install Python Libraries   |
| `opencv`              | Install OpenCV 4.1.0       |

## Contribute

[Bug reports, suggestions](https://github.com/marcosgomesborges/dev-setup/issues), and [pull requests](https://github.com/marcosgomesborges/dev-setup/pulls) are welcome!

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0), and the accompanying source code is licensed under the [MIT license](LICENSE.md).
