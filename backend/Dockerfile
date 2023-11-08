FROM elixir:latest

WORKDIR /backend-app

COPY . .
COPY entrypoint.sh ./entrypoint.sh

ENTRYPOINT ["/bin/sh", "/backend-app/entrypoint.sh"]