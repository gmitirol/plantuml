ARG REGISTRY_PATH=gmitirol
FROM $REGISTRY_PATH/alpine39:1.1.1
LABEL maintainer="gmi-edv@i-med.ac.at"

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
    git checkout 'v1.2019.5' && \
    mvn package && \
    cd "$BUILDDIR" && \
    wget 'https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.20/bin/apache-tomcat-9.0.20.tar.gz' && \
    tar xzf 'apache-tomcat-9.0.20.tar.gz' && \
    mv 'apache-tomcat-9.0.20' /home/project/tomcat && \
    cp plantuml-server/target/plantuml.war  /home/project/tomcat/webapps/plantuml.war && \
    echo '<html><head><meta charset="utf-8" /><title>PlantUML Server</title></head><body></body></html>' > /home/project/tomcat/webapps/ROOT/index.html && \
    chown -R project:project /home/project/ && \
    cd / && \
    rm -rf "$BUILDDIR";

ADD scripts/start.sh /start.sh

EXPOSE 8080
CMD ["/start.sh"]

