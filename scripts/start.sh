#!/bin/sh

set -e

exec sudo -u project -H /home/project/tomcat/bin/catalina.sh run
