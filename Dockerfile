FROM ubuntu:latest

USER root

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa wget
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.4-stable.tar.xz
RUN tar -xf ~/Downloads/flutter_linux_3.32.4-stable.tar.xz -C ~/development/
RUN echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bash_profile

CMD ["flutter", "--version"]