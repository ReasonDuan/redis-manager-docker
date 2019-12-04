FROM openjdk:8u181-jdk-alpine3.8

RUN apk add --update curl 

ARG SERVICE_DIR=/usr/local/redis-manager
ARG REMOTE_URL=https://github.com/ngbdf/redis-manager/releases/download/redis-manager-2.1.0/redis-manager-2.1.0.tar.gz
WORKDIR ${SERVICE_DIR}
RUN curl -fsSL -o redis-manager.tar.gz ${REMOTE_URL} \
  && tar -xf redis-manager.tar.gz \
  && mv redis-manager/* ./ \
  && cp conf/application.yml conf/application.yml.backup \
  && cp -r data backup_data \
  && rm -f conf/log4j2.xml \
  && rm -f redis-manager.tar.gz && rm -rf redis-manager 
  
COPY redis-manager-start.sh ${SERVICE_DIR}/
COPY log4j2.xml ${SERVICE_DIR}/conf/

ENTRYPOINT ["sh","./redis-manager-start.sh"]
