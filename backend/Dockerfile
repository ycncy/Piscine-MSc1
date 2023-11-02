FROM elixir:alpine

WORKDIR /backend-app

COPY . .
COPY entrypoint.sh ./entrypoint.sh



RUN mix archive.install hex phx_new && \
    mix deps.get

ENTRYPOINT ["/bin/sh", "/backend-app/entrypoint.sh"]