# mminderbinder/maven:oracle-java8
# Maven 3 and Oracle Java 8 JDK Docker Image
FROM mminderbinder/java-jdk:oracle-java8
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

RUN apt-get update && apt-get -y install maven

ENV MAVEN_PROJECTS_DIR /mnt/maven-projects
ENV M2_HOME /mnt/.m2

COPY maven-build.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/maven-build.sh

COPY settings.xml /root/.m2/settings.xml
RUN mkdir -p $M2_HOME/repository

VOLUME $MAVEN_PROJECTS_DIR
VOLUME $M2_HOME

WORKDIR $MAVEN_PROJECTS_DIR


# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init", "--", "/usr/local/bin/maven-build.sh"]
