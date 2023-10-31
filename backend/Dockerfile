FROM elixir:alpine

WORKDIR /backend-app

COPY . .
COPY entrypoint.sh ./entrypoint.sh



RUN mix local.hex --force && \
    mix archive.install --force hex phx_new && \
    mix deps.get

ENTRYPOINT ["/bin/bash", "/backend-app/entrypoint.sh"]