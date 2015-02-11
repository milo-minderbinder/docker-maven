#!/bin/bash

if [[ -z "$1" ]]; then
	maven_projects_dir=$(pwd)
else
	maven_projects_dir="${1}"
fi
echo "Running maven image with ${maven_projects_dir} mounted on /mnt/maven-projects"
docker run -it --rm -v ${maven_projects_dir}:/mnt/maven-projects --name maven mminderbinder/maven:oracle-java7 bash
