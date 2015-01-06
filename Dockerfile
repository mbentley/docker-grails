FROM debian:jessie
MAINTAINER Matt Bentley <mbentley@mbentley.net>
RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list)
RUN apt-get update

# install prereqs
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl git-core unzip wget

# install Oracle Java JDK 7
RUN (wget --no-check-certificate --no-cookies -O /tmp/jdk-7u60-linux-x64.tar.gz --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.tar.gz &&\
	echo "eba4b121b8a363f583679d7cb2e69d28  /tmp/jdk-7u60-linux-x64.tar.gz" | md5sum -c > /dev/null 2>&1 || echo "ERROR: MD5SUM MISMATCH" &&\
	tar xzf /tmp/jdk-7u60-linux-x64.tar.gz &&\
	mkdir -p /usr/lib/jvm &&\
	mv jdk1.7.0_60 /usr/lib/jvm/java-7-oracle &&\
	rm /tmp/jdk-7u60-linux-x64.tar.gz &&\
	chown root:root -R /usr/lib/jvm/java-7-oracle &&\
	update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/jre/bin/java 1 &&\
	update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java &&\
	update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-7-oracle/bin/javac 1 &&\
	update-alternatives --set javac /usr/lib/jvm/java-7-oracle/bin/javac &&\
	update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/java-7-oracle/bin/javaws 1 &&\
	update-alternatives --set javaws /usr/lib/jvm/java-7-oracle/bin/javaws)

# install grails
ENV GRAILS_VER 2.4.4
RUN (wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VER}.zip -O /opt/grails-${GRAILS_VER}.zip &&\
	cd /opt &&\
	unzip grails-${GRAILS_VER}.zip &&\
	rm grails-${GRAILS_VER}.zip &&\
	update-alternatives --install /opt/grails grails /opt/grails-${GRAILS_VER} 1)

# setup data directory
RUN mkdir /data
WORKDIR /data

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV GRAILS_HOME /opt/grails
ENV PATH $PATH:$GRAILS_HOME/bin

ENTRYPOINT ["grails","--plain-output"]
CMD ["help"]
