FROM elixir:latest

RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install -yq postgresql-client

RUN mkdir backend-app
COPY . /backend-app
COPY entrypoint.sh /backend-app/entrypoint.sh

WORKDIR /backend-app

RUN mix local.hex --force && \
    mix archive.install --force hex phx_new

RUN chmod +x /backend-app/entrypoint.sh
ENTRYPOINT ["/bin/bash", "/backend-app/entrypoint.sh"]