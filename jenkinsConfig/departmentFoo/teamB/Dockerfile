FROM jenkins/jenkins:2.142-slim

USER root
RUN apt-get update && apt-get install -y vim
USER jenkins

# Disable plugin banner on startup
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY config/*.xml /usr/share/jenkins/ref/
COPY startup/config.groovy /usr/share/jenkins/ref/init.groovy.d/config.groovy
# COPY startup/init-docker-registry-env.groovy /usr/share/jenkins/ref/init.groovy.d/init-docker-registry-env.groovy

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
