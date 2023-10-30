while ! pg_isready -q -h "$PGHOST" -p "$PGPORT" -U "$PGUSER"
do
  echo "$(date) - Waiting for database to start"
  sleep 2
done

mix deps.get

# shellcheck disable=SC2006
if [[ -z `psql -Atqc "\\list $PGDATABASE" postgres` ]]; then
  echo "Couldn't find database $PGDATABASE"
  mix ecto.create
  echo "Database $PGDATABASE created"
fi

mix ecto.migrate
exec mix phx.server