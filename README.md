mbentley/grails2.4.2
===========================

docker image for grails 2.4.2 (with Oracle JDK)
based off of stackbrew/debian:jessie

To pull this image:
`docker pull mbentley/grails2.4.2`

Example usage:

Note: The default ENTRYPOINT is `grails --plain-output` with the default CMD being `help`

### Execute `grails run-app`
`docker run -it --rm -p 8080:8080 -v /home/mbentley/mygrailsapp:/data mbentley/grails2.4.2 run-app`

### Execute `grails war mywar.war`
`docker run -it --rm -v /home/mbentley/mygrailsapp:/data mbentley/grails2.4.2 war mywar.war`
