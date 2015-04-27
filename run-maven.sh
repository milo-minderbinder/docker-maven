#!/bin/bash

mnt_m2=""
if [[ -n "$M2_HOME" ]]; then
	mnt_m2="-v ${M2_HOME}:/mnt/.m2"
	echo "Will mount \$M2_HOME with: '${mnt_m2}'"
fi

usage() {
	echo "Usage: ${0} [-t <tag>] [<path/to/volume>]"
	echo "Maven Docker run script"
	exit 0
}

maven_projects_dir="${HOME}/Projects"
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
docker run -it --rm ${mnt_m2} -v ${maven_projects_dir}:/mnt/maven-projects --name maven mminderbinder/maven:${tag} bash
