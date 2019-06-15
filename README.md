# Development Environment Setup

Setting up a new development environment can be a manual and time-consuming process. This project aims to simplify the process with easy instructions and scripts to automate the setup of the following:

* GNU/Linux
* macOS
* Windows
* Docker

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

macOS terminal with devsetup `.bash_profile` and `.inputrc`

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

| macOS Package     | Description                                                                   |
| ---               | ---                                                                           |
| `devsetup`        | Update devsetup script (download the latest version)                          |
| `git`             | Set-up git with username, email, and terminal colors                          |
| `bash-profile`    | Set-up bash_profile                                                           |
| `inputrc`         | Improve command line history search                                           |

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

## Contribute

[Bug reports, suggestions](https://github.com/marcosgomesborges/dev-setup/issues), and [pull requests](https://github.com/marcosgomesborges/dev-setup/pulls) are welcome!

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0), and the accompanying source code is licensed under the [MIT license](LICENSE.md).
