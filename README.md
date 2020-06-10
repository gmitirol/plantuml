Docker image for PlantUML server
================================

Provides a minimal PlantUML server docker image based on our [Alpine Linux 3.11 base image](https://github.com/gmitirol/alpine311/) and the [PlantUML server](https://github.com/plantuml/plantuml-server) project.
The default PlantUML tomcat port `8080` is exposed for HTTP by default, but can be configured via docker compose/swarm service definitions.
