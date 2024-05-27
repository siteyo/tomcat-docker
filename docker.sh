#!/bin/bash

build() {
	docker build . -t my_tomcat
}

start() {
	docker run -it --rm -p 8080:8080 my_tomcat
}

main() {
	set -euo pipefail

	if [ $# = 0 ]; then
		echo "[usage]"
		echo "  build: bash docker.sh build"
		echo "  start: bash docker.sh start"
		exit 1
	fi

	while [ $# -gt 0 ]; do
		case ${1} in
		build) build ;;
		start) start ;;
		*)
			print "Invalid arguments ${1}"
			exit 1
			;;
		esac
		shift
	done
}

main "$@"
