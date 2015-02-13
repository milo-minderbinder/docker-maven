#!/bin/bash


usage() {
	echo "Usage: ${0} [-t <tag>] [<path/to/volume>]"
	echo "Maven Docker run script"
	exit 0
}

maven_projects_dir="$(pwd)"
tag="latest"

if [[ -n "$1" ]]; then
	if [[ $1 == "-h" ]]; then
		usage
	fi
	if [[ $1 == "-t" ]]; then
		tag="${2}"
		if [[ -n "$3" ]]; then
			maven_projects_dir="${3}"
		fi
	else
		maven_projects_dir="${1}"
	fi
fi

echo "Running maven:${tag} image with ${maven_projects_dir} mounted on /mnt/maven-projects"
docker run -it --rm -v ${maven_projects_dir}:/mnt/maven-projects --name maven mminderbinder/maven:${tag} bash
