#!/bin/bash

if [[ -z "${MAVEN_PROJECTS_DIR}" ]]; then
	MAVEN_PROJECTS_DIR=/mnt/maven-projects
fi

for item in $MAVEN_PROJECTS_DIR/* ; do
	if [[ ! -d "${item}" ]]; then
		echo "Not a project directory, skipping: ${item}"
	else
		cd ${item}
		echo "Building ${item}..."
		mvn clean package -Dmaven.compiler.source=1.7 -Dmaven.compiler.target=1.7
	fi
done
