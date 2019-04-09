FROM maven:3.6.0-jdk-8-alpine

RUN apk add --no-cache unzip git

ARG SERVICE_DIR=/usr/share/redis-manager
ARG REMOTE_URL=https://github.com/ngbdf/redis-manager/archive/redismanager-1.1-release.zip
ARG TEMP_DIR=/tmp/redis-manager-docker

RUN curl -fsSL -o /tmp/redis-manager.tar.zip ${REMOTE_URL} \
  && unzip /tmp/redis-manager.tar.zip -d /tmp \
  && mvn clean package -Dmaven.test.skip=true -f ${TEMP_DIR} \
  && mkdir ${SERVICE_DIR} && mkdir ${SERVICE_DIR}/logs && mkdir ${SERVICE_DIR}/web \
  && mkdir ${SERVICE_DIR}/conf && mkdir ${SERVICE_DIR}/lib \
  && cp -f ${TEMP_DIR}/target/redis-manager*.jar ${SERVICE_DIR} \
  && cp -rf ${TEMP_DIR}/target/lib/* ${SERVICE_DIR}/lib \
  && cp -rf ${TEMP_DIR}/target/classes/* ${SERVICE_DIR}/web \
  && cp ${SERVICE_DIR}/web/application.yml ${SERVICE_DIR}/web/application.yml.base \
  && rm -rf /tmp/redis-manager*
  
COPY *.sh ${SERVICE_DIR}/

WORKDIR ${SERVICE_DIR}
ENTRYPOINT ["sh","./redis-manager-start.sh"]
