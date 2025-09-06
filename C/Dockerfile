FROM docker.io/codercom/code-server:noble

USER root

RUN apt update
RUN apt install -y gcc valgrind check pkg-config clangd make libsystemd-dev

ENV ENTRYPOINTD="/home/coder/template/entrypoint.d/"
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/home/coder/project"]
RUN mkdir -p /usr/bin/bak/gcc
RUN mv /usr/bin/gcc /usr/bin/bak/gcc
COPY --chown=root:root intercept-gcc.sh /usr/bin/gcc
COPY --chown=root:root asanlog.sh /usr/bin/asanlog


USER coder

RUN code-server --install-extension ngtystr.ppm-pgm-viewer-for-vscode  
RUN code-server --install-extension llvm-vs-code-extensions.vscode-clangd  
RUN code-server --install-extension eclipse-cdt.cdt-gdb-vscode

RUN mkdir -p /home/coder/template/entrypoint.d
RUN mkdir -p /home/coder/.config/code-server
COPY --chown=coder:coder Makefile /home/coder/template
COPY --chown=coder:coder tasks.json /home/coder/template
COPY --chown=coder:coder settings.json /home/coder/template
COPY --chown=coder:coder entrypoint.d/* /home/coder/template/entrypoint.d/


