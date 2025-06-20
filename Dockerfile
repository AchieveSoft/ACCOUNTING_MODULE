FROM ubuntu:latest

USER root

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa wget
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.4-stable.tar.xz
RUN mkdir /root/development/
RUN tar -xf flutter_linux_3.32.4-stable.tar.xz -C /root/development/
RUN echo 'export PATH="/root/development/flutter/bin:$PATH"' >> /root/.bashrc

CMD ["bash"]