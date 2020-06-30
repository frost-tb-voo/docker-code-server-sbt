FROM node:latest as extension

WORKDIR /metals
RUN git clone https://github.com/scalameta/metals-vscode.git \
 && cd ./metals-vscode \
 && npm install --silent \
 && npm audit fix --force \
 && npm cache clean --force \
 && rm -rf node_modules package-lock.json \
 && npm install --silent \
 && npm audit fix --force \
 && npm install -g vsce \
 && vsce package \
 && npm cache clean --force \
 && rm -rf ~/.npm \
 && mv *.vsix ../ \
 && cd ../ \
 && rm -rf /metals/metals-vscode

FROM mozilla/sbt:latest as sbt

FROM codercom/code-server:latest
ARG VCS_REF
ARG BUILD_DATE

LABEL maintainer="Novs Yama" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/frost-tb-voo/docker-code-server-sbt"

USER root
COPY --from=sbt /usr/local/openjdk-8 /usr/local/openjdk-8
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=${PATH}:${JAVA_HOME}/bin
COPY --from=sbt /usr/share/sbt /usr/share/sbt
RUN ln -s /usr/share/sbt/bin/sbt /usr/bin/
#RUN ls -la /usr/share/sbt \
# && ls -la /usr/local/openjdk-8

ADD settings.json /home/coder/.local/share/code-server/User/settings.json
ADD settings.json /home/coder/.local/share/code-server/Machine
ADD settings.json /home/coder/project/.vscode/settings.json
COPY --from=extension /metals/*.vsix /home/coder/
RUN chown -hR coder /home/coder

USER coder
WORKDIR /home/coder/project
RUN code-server --install-extension /home/coder/*.vsix \
 && rm -f /home/coder/*.vsix

