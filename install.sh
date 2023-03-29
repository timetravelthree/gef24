#!/bin/sh -eu

GEF24_INSTALLATION_PATH="${HOME}/.gdbinit-gef24.py"

INFOF=$(tput setaf 255)
INFOB=$(tput setab 235)
SUCCESSF=$(tput setaf 46)
SUCCESSB=
RESET=$(tput sgr0)

# Simple log function
log() {
	typem=$2
	message=$1
	case $typem in
	info)
		echo "${INFOB}${INFOF}[?] Info: ${RESET}${INFOB} $message ${RESET}"
		;;
	success)
		echo "${SUCCESSB}${SUCCESSF}[@] Success: ${RESET}${SUCCESSB} $message ${RESET}"
		;;
	esac
}

log "Installing Gef24!" info

log "Installing dependencies" info

log "Installing python3-pip dependencies" info
set -x
pip3 install ropper keystone-engine --break-system-packages
set +x

if [ ! "$(command -v seccomp-tools)" ]; then
	log "Installing seccomp-tools" info
	set -x gem install --user seccomp-tools
	set +x
else
	log "Detected seccomp-tools, skipping..." info
fi

if [ ! "$(command -v one_gadget)" ]; then
	log "Installing one_gadget" info
	set -x
	gem install --user one_gadget
	set +x
else
	log "Detected one_gadget, skipping..." info
fi

log "Installing rp++" info
if [ "$(uname -m)" = "x86_64" ]; then
	if [ ! "$(command -v rp-lin)" ]; then
		set -x
		wget -q https://github.com/0vercl0k/rp/releases/download/v2.1.1/rp-lin-clang.zip -P /tmp
		unzip /tmp/rp-lin-clang.zip -d "${HOME}/.local/bin/"
		chmod +x "${HOME}/.local/bin/rp-lin"
		rm /tmp/rp-lin-clang.zip
		set +x
	else
		log "Detected rp-lin, skipping..." info
	fi
fi

log "Installing vmlinux-to-elf" info
if [ ! "$(command -v vmlinux-to-elf)" ]; then
	set -x
	pip3 install --user --upgrade lz4 zstandard git+https://github.com/clubby789/python-lzo@b4e39df git+https://github.com/marin-m/vmlinux-to-elf --break-system-packages
	set +x
fi

log "Downloading Gef24" info
set -x
wget -q https://raw.githubusercontent.com/timetravelthree/gef24/dev/gef.py -O "${GEF24_INSTALLATION_PATH}"
set +x

log "Setting up" info
STARTUP_COMMAND="source ${GEF24_INSTALLATION_PATH}"

if [ -e "${HOME}/.gdbinit" ] && grep -q "${STARTUP_COMMAND}" "${HOME}/.gdbinit"; then
	log "Gef24 seems to be already installed" info
else
	set -x

	cat <<EOH >>"${HOME}/.gdbinit"

# --Gef24 source file--

define init-gef24
${STARTUP_COMMAND}
end
document init-gef24
Initializes Gef24
end

# --Gef24 EOH--

init-gef24

EOH

	set +x
fi

log "Installing Gef24 script into ${HOME}/.local/bin/gef24" info
set -x
cat <<EOH >"${HOME}/.local/bin/gef24"
#!/bin/sh
#exec gdb -q -ex init-gef24 "$@"
EOH
chmod +x ${HOME}/.local/bin/gef24
set +x

log "Installation finished successfully!" success
log 'Now try to run `gef24 ${BINARY_NAME}`' success

exit 0
