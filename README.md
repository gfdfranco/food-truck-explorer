# Food Truck Explorer Backend

## Project Overview
Food Truck Explorer is a GraphQL API designed to help users discover and manage their favorite food trucks in San Francisco. The project uses data from San Francisco's open dataset on food trucks to provide users with an interactive and personalized experience. This backend can be used to power various client applications, including web and mobile interfaces.

## Features
- User authentication (signup, login and signout)
- Browse food trucks in San Francisco
- Save favorite food trucks
- GraphQL API for flexible data querying

Demo video to see Food Truck Explorer in action:

[![Food Truck Explorer Demo](https://img.youtube.com/vi/QQSSC4o0-2Y/0.jpg)](https://www.youtube.com/watch?v=QQSSC4o0-2Y "Food Truck Explorer Demo")

This video provides an overview of the main features and functionality of our Food Truck Explorer application.

## Tech Stack
- Backend: Phoenix (Elixir) with GraphQL (Absinthe)
- Database: PostgreSQL
- Containerization: Docker and Docker Compose
- CI/CD: GitHub Actions

## Project Structure
```
food-truck-explorer/
├── backend/
│   ├── backend_project/     # Main Phoenix application
│   │   ├── config/          # Configuration files
│   │   ├── lib/             # Application code
│   │   ├── priv/            # Database migrations and seeds
│   │   ├── test/            # Test files
│   │   ├── mix.exs          # Project dependencies and configuration
│   │   └── mix.lock         # Lock file for dependencies
│   ├── docker-compose.yml           # Docker Compose for local development
│   ├── docker-compose-deploy.yml    # Docker Compose for production deployment
│   ├── Dockerfile                   # Docker configuration
│   └── entrypoint.sh                # Docker entrypoint script
└── README.md                # This file
```

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

For more detailed setup instructions, refer to the following README files:
- [Backend Setup README](backend/README.md)
- [Phoenix Project README](backend/backend_project/README.md)

## GraphQL API

The GraphQL API provides a flexible interface for client applications to interact with the Food Truck Explorer backend. It allows for efficient querying of food truck data, user authentication, and management of favorite food trucks.

Key features of the API include:
- User authentication and authorization
- Querying food truck data with various filters
- Saving and retrieving user favorites
- Health check endpoint for monitoring

To explore the API, you can use the GraphiQL interface available in the development environment at `http://localhost:4000/api/graphiql` (adjust the port if necessary).

## Continuous Integration

This project uses GitHub Actions for continuous integration. The workflow configurations can be found in the `.github/workflows` directory (not visible in the provided structure, but assumed to exist). These workflows automate the process of testing and building the GraphQL API whenever changes are pushed to the repository.

## Why GraphQL?

I chose GraphQL over a traditional RESTful API for several reasons:

1. Flexible Data Fetching: GraphQL allows clients to request exactly the data they need, reducing over-fetching and under-fetching of data.
2. Strong Typing: GraphQL's type system provides clear contracts between the frontend and backend, reducing errors and improving development speed.
3. Single Endpoint: GraphQL's single endpoint approach simplifies API management and versioning compared to multiple REST endpoints.
