#!/bin/sh -eux

GEF24_INSTALLATION_PATH="${HOME}/.gdbinit-gef24.py"

echo "[+] apt"
apt-get update
apt-get install -y gdb-multiarch binutils gcc file

echo "[+] download gef"
wget -q https://raw.githubusercontent.com/timetravelthree/gef24/dev/gef.py -O "${GEF24_INSTALLATION_PATH}"

echo "[+] setup gef"
STARTUP_COMMAND="source ${GEF24_INSTALLATION_PATH}"
if [ ! -e "${HOME}/.gdbinit" ] || grep -q "${STARTUP_COMMAND}" "${HOME}/.gdbinit"; then
	echo "${STARTUP_COMMAND}" >>"${HOME}/.gdbinit"
fi

exit 0
