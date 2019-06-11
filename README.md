# Development Environment Setup

Setting up a new development environment can be a manual and time-consuming process. This project aims to simplify the process with easy instructions and scripts to automate the set-up of the following:

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
| `-u, --update`    | update a package                                  |
| `-i, --install`   | install a package                                 |

## Install devsetup for macOS

To install devsetup for macOS to `/usr/local`, paste at a terminal prompt:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/marcosgomesborges/dev-setup/master/install_macos)
```

### devsetup install for macOS

To install a package: `devsetup install <package>`

| Package           | Description                                                                   |
| ---               | ---                                                                           |
| `homebrew`        | Install Hombrew and its dependencies: GCC and Command Line Tools with Headers |

## Contribute

[Bug reports, suggestions](https://github.com/marcosgomesborges/dev-setup/issues), and [pull requests](https://github.com/marcosgomesborges/dev-setup/pulls) are welcome!

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0), and the accompanying source code is licensed under the [MIT license](LICENSE.md).
