ARG REGISTRY_PATH=gmitirol
FROM $REGISTRY_PATH/alpine312:v1
LABEL maintainer="gmi-edv@i-med.ac.at"

ARG PLANTUML_VERSION="v1.2020.18"
ARG TOMCAT_VERSION="9.0.39"

RUN set -xe && \
    BUILDDIR='/root/build' && \
    adduser -u 1000 -D project && \
    apk --no-cache --update upgrade && \
    apk add --no-cache --update sudo graphviz openjdk8 maven fontconfig fontconfig-dev msttcorefonts-installer && \
    update-ms-fonts && \
    fc-cache -f && \
    mkdir "$BUILDDIR" && \
    cd "$BUILDDIR" && \
    git clone 'https://github.com/plantuml/plantuml-server.git' && \
    cd plantuml-server && \
    git checkout "$PLANTUML_VERSION" && \
    mvn package && \
    cd "$BUILDDIR" && \
    wget "https://www-eu.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" && \
    tar xzf "apache-tomcat-${TOMCAT_VERSION}.tar.gz" && \
    mv "apache-tomcat-${TOMCAT_VERSION}" /home/project/tomcat && \
    cp plantuml-server/target/plantuml.war  /home/project/tomcat/webapps/plantuml.war && \
    echo '<html><head><meta charset="utf-8" /><title>PlantUML Server</title></head><body></body></html>' > /home/project/tomcat/webapps/ROOT/index.html && \
    chown -R project:project /home/project/ && \
    cd / && \
    rm -rf "$BUILDDIR";

ADD scripts/start.sh /start.sh

EXPOSE 8080
CMD ["/start.sh"]

