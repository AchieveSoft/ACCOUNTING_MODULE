FROM ubuntu:latest

USER root

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa wget
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.32.4-stable.tar.xz
RUN mkdir /root/development/
RUN tar -xf flutter_linux_3.32.4-stable.tar.xz -C /root/development/
RUN git config --global --add safe.directory /root/development/flutter

ENV PATH="/root/development/flutter/bin:${PATH}"

WORKDIR /app/

COPY . /app/

RUN git clone $(echo $(git remote get-url origin) | sed 's/ACCOUNTING_MODULE/ERP_FLUTTER_CORE_MODULE/g') ../erp_flutter_core_module

RUN flutter pub get && \
    flutter build web --wasm

RUN rm -rf /var/www/html/* && \
    cp -f build/web/* /var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]