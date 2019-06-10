# Development Environment Setup

Setting up a new development environment can be a manual and time-consuming process. This project aims to simplify the process with easy instructions and scripts to automate the set-up of the following:

* GNU/Linux
* macOS
* Windows
* Docker

## Install macOS

```bash
# Installer macOS setup
curl -fsSL https://raw.githubusercontent.com/marcosgomesborges/dev-setup/master/macos -o /usr/local/bin/macos && chmod +x /usr/local/bin/macos
```

This script installs setup-macos to `/usr/local` so that you don’t need sudo when you macos install. It is a careful script; it can be run even if you have stuff installed to `/usr/local` already. It tells you exactly what it will do before it does it too. You have to confirm everything it will do before it starts.

## Contribute

[Bug reports, suggestions](https://github.com/marcosgomesborges/dev-setup/issues), and [pull requests](https://github.com/marcosgomesborges/dev-setup/pulls) are welcome!

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0), and the accompanying source code is licensed under the [MIT license](LICENSE.md).
