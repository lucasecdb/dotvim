# Vim config files

## Installation

First, init and update the submodules to get `minpac`

```sh
$ git submodule update --init
```

Then, tell minpac to get and update the plugins used, before opening for the first time

```sh
$ nvim -c "call minpack#update()"
```

