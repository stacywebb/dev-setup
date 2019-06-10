# Development Environment Setup

Setting up a new development environment can be a manual and time-consuming process. This project aims to simplify the process with easy instructions and scripts to automate the set-up of the following:

* GNU/Linux
* macOS
* Windows
* Docker

## Install macOS-setup

To install setup-macos to `/usr/local`, paste at a terminal prompt:

```bash
curl -fsSL https://raw.githubusercontent.com/marcosgomesborges/dev-setup/master/macos -o /usr/local/bin/macos && chmod +x /usr/local/bin/macos
```

### macOS-setup essential commands

The basic macos-setup command takes this form: `macos <command>`

| Command           | Description                                       |
| ---               | ---                                               |
| `-h, --help`      | print the help message                            |
| `-v, --version`   | print the version number of macos-setup script    |
| `-u, --update`    | update macos-setup script                         |

## Contribute

[Bug reports, suggestions](https://github.com/marcosgomesborges/dev-setup/issues), and [pull requests](https://github.com/marcosgomesborges/dev-setup/pulls) are welcome!

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0), and the accompanying source code is licensed under the [MIT license](LICENSE.md).
