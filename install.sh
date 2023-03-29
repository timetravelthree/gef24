#!/bin/sh -eux

GEF24_INSTALLATION_PATH="${HOME}/.gdbinit-gef24.py"

echo "[+] pip3"
pip3 install ropper keystone-engine

echo "[+] install seccomp-tools, one_gadget"
if [ "$(command -v seccomp-tools)" ]; then
	gem install seccomp-tools
fi

if [ "$(command -v one_gadget)" ]; then
	gem install one_gadget
fi

echo "[+] install rp++"
if [ "$(uname -m)" ]; then
	if [ "$(command -v rp-lin)" ]; then
		wget -q https://github.com/0vercl0k/rp/releases/download/v2.1.1/rp-lin-clang.zip -P /tmp
		unzip /tmp/rp-lin-clang.zip -d /usr/local/bin/
		chmod +x /usr/local/bin/rp-lin
		rm /tmp/rp-lin-clang.zip
	fi
fi

echo "[+] install vmlinux-to-elf"
if [ "$(command -v vmlinux-to-elf)" ]; then
	pip3 install --upgrade lz4 zstandard git+https://github.com/clubby789/python-lzo@b4e39df
	pip3 install --upgrade git+https://github.com/marin-m/vmlinux-to-elf
fi

echo "[+] download gef"
wget -q https://raw.githubusercontent.com/timetravelthree/gef24/dev/gef.py -O "${GEF24_INSTALLATION_PATH}"

echo "[+] setup gef"
STARTUP_COMMAND="source ${GEF24_INSTALLATION_PATH}"
if [ ! -e "${HOME}/.gdbinit" ] || grep -q "${STARTUP_COMMAND}" "${GEF24_INSTALLATION_PATH}"; then
	echo "$STARTUP_COMMAND" >>"${HOME}/.gdbinit"
fi

exit 0
