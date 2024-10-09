# Food Truck Explorer Backend

This is the backend component of the Food Truck Explorer project, built with Phoenix and GraphQL.

## Getting Started

To set up and run the Food Truck Explorer backend:

1. Ensure you have Docker and Docker Compose installed on your system.
2. Clone this repository.
3. Navigate to the `backend` directory.
4. Create a `.env` file by copying the sample:
   ```
   cp .env.sample .env
   ```
   Open the `.env` file and configure the environment variables according to your setup. Make sure to set appropriate values for database credentials, API keys, and any other required variables.
5. Run `docker-compose up --build` to start the development environment.

The application should now be running and accessible. You can access the GraphiQL interface at `http://localhost:4000/api/graphiql` (adjust the port if you've configured a different one in your `.env` file).

## Testing

To run the test suite, use the following command:

```
docker compose run --rm backend mix test
```

This command runs the tests inside the Docker container, ensuring a consistent environment for testing.

## Data Seeding

On the first run, if the food trucks table is empty, the system will automatically read the CSV file containing San Francisco food truck data and insert it into the database. This ensures that you have initial data to work with.

The seed process is part of the application startup and is executed automatically. You don't need to run any additional commands to populate the database with initial food truck data.

## Database Access with pgAdmin

For easy database management and exploration, you can use pgAdmin, which is included in the Docker setup. To access pgAdmin:

1. Ensure your Docker containers are running (`docker-compose up`).
2. Open your web browser and navigate to:
   ```
   http://localhost:5050/
   ```
3. Log in using the credentials you set in your `.env` file for pgAdmin.
4. To connect to your database, create a new server connection with the following details:
   - Host: `db` (this is the service name in docker-compose)
   - Port: 5432 (default PostgreSQL port)
   - Username and Password: Use the values you set in your `.env` file for the database

With pgAdmin, you can browse your database structure, run queries, and manage your data visually.

## GraphQL API

The GraphQL API is the primary interface for interacting with the Food Truck Explorer backend. It provides endpoints for:

- User authentication (signup and login)
- Querying food truck data
- Managing user favorites

To explore the available queries and mutations, use the GraphiQL interface at `http://localhost:4000/api/graphiql`.

## Development

For development, you can use the following commands:

- To start the Phoenix server:
  ```
  docker compose up
  ```
- To run database migrations:
  ```
  docker compose run --rm backend mix ecto.migrate
  ```
- To access an IEx (Interactive Elixir) console:
  ```
  docker compose run --rm backend iex -S mix
  ```

## Troubleshooting

If you encounter any issues:

1. Ensure all required environment variables are set in your `.env` file.
2. Try rebuilding the Docker containers:
   ```
   docker compose down
   docker compose up --build
   ```
3. Check the Docker logs for any error messages:
   ```
   docker compose logs backend
   ```

For more detailed information about the Phoenix framework, visit the [official Phoenix documentation](https://hexdocs.pm/phoenix/overview.html).