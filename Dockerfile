FROM ubuntu:latest

USER root

WORKDIR /app/
COPY . /app/

RUN ./scripts/setup-docker-image

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]