mbentley/grails
===========================

docker image for grails (with Oracle JDK)
based off of stackbrew/debian:jessie

*Note*:  See the subdirectories for different Docker tags for specific versions of Grails

To pull this image:
`docker pull mbentley/grails:latest`

Example usage:

Note: The default ENTRYPOINT is `grails --plain-output` with the default CMD being `help`

### Execute `grails run-app`
`docker run -it --rm -p 8080:8080 -v /home/mbentley/mygrailsapp:/data mbentley/grails:latest run-app`

### Execute `grails war mywar.war`
`docker run -it --rm -v /home/mbentley/mygrailsapp:/data mbentley/grails:latest war mywar.war`
