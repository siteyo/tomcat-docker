#!/bin/bash

install() {
	local current_dir dotfiles_dir
	current_dir=$(dirname "${BASH_SOURCE[0]}")
	dotfiles_dir=$(builtin cd "${current_dir}" && git rev-parse --show-toplevel)

	cd "${dotfiles_dir}" && brew bundle --file ./Brewfile

	limactl create --name=docker template://docker --tty=false
	limactl start docker

	docker context create lima-docker --docker "host=unix:///Users/SaitoYuki/.lima/docker/sock/docker.sock"
	docker context use lima-docker
}

uninstall() {
	limactl stop docker
	limactl delete docker
}

main() {
	set -euo pipefail

	if [ $# = 0 ]; then
		echo "[usage]"
		echo "  install:   bash setup.sh install"
		echo "  uninstall: bash setup.sh uninstall"
		exit 1
	fi

	while [ $# -gt 0 ]; do
		case ${1} in
		install) install ;;
		uninstall) uninstall ;;
		*)
			print "Invalid arguments ${1}"
			exit 1
			;;
		esac
		shift
	done
}

main "$@"
