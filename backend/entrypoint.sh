#!/bin/bash
# Docker entrypoint script.

# Exit the script on any command with non 0 return code.
set -e

wait_for_postgres() {
  while ! pg_isready -h $PGHOST -U $PGUSER -p $PGPORT; do
    echo "$PGUSER:$PGHOST:$PGPORT - Postgres is unavailable - sleeping"
    sleep 1
  done
  echo "Postgres is up - executing command"
}

# Call the wait function
wait_for_postgres

cd /home/gfdfranco/workspace/backend_project

# Check the value of ENV_DEV variable
if [ "$ENV_DEV" = "true" ]; then
    # If ENV_DEV is true
    mix local.rebar --force
    mix local.hex --force
    mix deps.get --force
    mix compile --force

    # Check if database exists, create if it doesn't
    if mix ecto.create; then
        echo "Database already exists"
    else
        echo "Creating database"
        mix ecto.create
    fi

    mix ecto.migrate
    mix run priv/repo/seeds.exs
    mix phx.server
else
    # If ENV_DEV is false
    mix deps.get --only prod
    MIX_ENV=prod mix compile
    MIX_ENV=prod mix ecto.migrate
    MIX_ENV=prod mix run priv/repo/seeds.exs
    PORT=4000 MIX_ENV=prod mix phx.server
fi