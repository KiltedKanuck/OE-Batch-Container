# -------------- DOWNLOADER IMAGE -------------
#build a downloader to get the openedge file
FROM alpine:latest AS downloader
# we need curl to 'get' the binary
RUN apk --no-cache add curl
# get the binary 
RUN curl http://ec2-54-80-142-101.compute-1.amazonaws.com:8081/repository/PugChallengeMaven/OpenEdge/linux/12.8.0/linux-12.8.0.tar > openedge.tar

# -------------- BUILDER IMAGE -------------
# use a builder to do the install. This will keep the image smaller
FROM eclipse-temurin:17.0.8.1_1-jdk-focal AS builder

RUN mkdir /installer
COPY ./response.ini /etc
WORKDIR /installer
COPY --from=downloader openedge.tar ./
RUN tar -xvf openedge.tar

WORKDIR /etc
RUN /installer/proinst -b ./response.ini -l ./install.log
RUN cat ./install.log

# cleanup stuff we do not need for runtime
RUN rm -rf /psc/oemgmt/ \
    /psc/wrk_oemgmt/ \
    /psc/dlc/ant/ \
    /psc/dlc/demo* \
    /psc/dlc/empty* \
    /psc/dlc/esbadapter/ \
    /psc/dlc/gradle/ \
    /psc/dlc/hello \
    /psc/dlc/inst_hlp \
    /psc/dlc/install* \
    /psc/dlc/*sports* \
    /psc/dlc/javahelp/ \
    /psc/dlc/newkw* \
    /psc/dlc/notice.txt \
    /psc/dlc/odbc/ \
    /psc/dlc/oebuild/ \
    /psc/dlc/ora/ \
    /psc/dlc/pct/ \
    /psc/dlc/prohelp/ \
    /psc/dlc/prolang/ \
    /psc/dlc/servers/ \
    /psc/dlc/sonic/ \
    /psc/dlc/templates/ \
    /psc/dlc/ubqmanager/

# fix permissions
RUN find /psc/dlc -type d -exec chmod 'o-w' '{}' ';' &&\
    find /psc/dlc -type f -exec chmod 'o-rwx' '{}' ';' 

# -------------- FINAL IMAGE -------------
# Now create final container as small as possible
FROM eclipse-temurin:17.0.8.1_1-jdk-focal

#copy /psc from the builder instance to this one
COPY --from=builder /psc /psc
# we need to enable TCP 
RUN echo 'tcp    6 TCP' >> /etc/protocols
#setup some ENV variables
ENV PATH=/psc/dlc:/psc/dlc/bin:/psc/dlc/ant/bin:$PATH \
    WRKDIR=/psc/wrk/ \
    DLC=/psc/dlc/

LABEL maintainer="cameron.wright@progress.com"

