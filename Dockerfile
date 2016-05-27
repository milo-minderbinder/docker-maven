# mminderbinder/maven:latest
# Maven 3 and Oracle Java 8 JDK Docker Image
FROM mminderbinder/java-jdk:oracle-java8
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

RUN apt-get update && apt-get -y install maven

ENV MAVEN_PROJECTS_DIR /mnt/maven-projects
ENV MAVEN_USER_HOME /root/.m2
ENV M2_HOME /usr/share/maven

COPY maven-build.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/maven-build.sh

RUN mkdir -p $MAVEN_USER_HOME/repository

VOLUME $MAVEN_PROJECTS_DIR
VOLUME $MAVEN_USER_HOME

WORKDIR $MAVEN_PROJECTS_DIR


# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init", "--", "/usr/local/bin/maven-build.sh"]
