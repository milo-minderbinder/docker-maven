# mminderbinder/maven:oracle-java7
# Maven 3 and Oracle Java 7 JDK Docker Image
FROM mminderbinder/java-jdk:oracle-java7
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

RUN apt-get update && apt-get -y install maven

ENV MAVEN_PROJECTS_DIR /mnt/maven-projects

COPY maven-build.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/maven-build.sh

VOLUME $MAVEN_PROJECTS_DIR
WORKDIR $MAVEN_PROJECTS_DIR


# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init", "--", "/usr/local/bin/maven-build.sh"]
