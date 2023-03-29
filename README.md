# GEF24
The aim of this fork is to add some additional features to the already existing [GEF](https://github.com/bata24/gef). You can see a full list of the commands in the original repository. Here, I list only some additional improved features that I have added.

## Acknowledgements

This repository is a fork of [GEF](https://github.com/bata24/gef) by `@bata_24`, which is derived from the original [GEF](https://github.com/hugsy/gef) by `@hugsy`

## Setup

### Dependencies

Make sure to have at least the following dependencies installed:

```sh
sudo apt update
sudo apt install -y gdb-multiarch binutils gcc file ruby-dev git python3-pip python3-crccheck python3-unicorn python3-capstone 
```

### Install

```sh
wget -q https://raw.githubusercontent.com/timetravelthree/gef24/dev/install.sh -O- | sh
```

### Upgrade (replaces itself)
```sh
python3 "${HOME}/.gdbinit-gef24.py" --upgrade
```

### Uninstall

There will also be a command left in `${HOME}/.gdbinit` named `init-gef24` that you must remove

```sh
rm -f "${HOME}/.gdbinit-gef24.py" "${HOME}/.local/bin/gef24"
```

Remove the Gef24 source script


### Added/Improved Features
* Installation without root
* idtinfo: added command for printing idt gates
* ksymaddr-*: improved compatibility for most Linux kernels

## Added / Improved features

- installation without root
- `idtinfo` command for printing idt gates
- `ksymaddr-*` improved compatibility for most linux kernels

### General
* `idtinfo`: displays the IDT gates
    * It also prints the details of each section of the entry.
    ![](images/interrupt_gates.png)


## Todo
 - [ ] Better file structure, for easier organization.
 - [ ] Improve `idtinfo` to add 32-bit support.
