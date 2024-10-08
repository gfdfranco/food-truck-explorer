# Food Truck Explorer

## Project Overview
Food Truck Explorer is a web application designed to help users discover and manage their favorite food trucks in San Francisco. The project uses data from San Francisco's open dataset on food trucks to provide users with an interactive and personalized experience.

## Features
- User authentication (signup and login)
- Browse food trucks in San Francisco
- Save favorite food trucks
- Create a "Want to Visit" list
- See location on map of food truck locations

## Tech Stack
- Backend: Phoenix (Elixir) with GraphQL
- Frontend: Next.js (React)
- Database: PostgreSQL
- Containerization: Docker and Docker Compose
- CI/CD: GitHub Actions (for GraphQL API)

## Project Structure
```
food-truck-explorer/
├── backend/           # Phoenix GraphQL API
├── frontend/          # Next.js web application
├── .github/
│   └── workflows/     # GitHub Actions workflow files
└── README.md          # This file
```

For specific setup and configuration instructions, please refer to the README files in the `backend/` and `frontend/` directories.

## Continuous Integration

This project uses GitHub Actions for continuous integration, specifically focused on the GraphQL API. The workflow configurations can be found in the `.github/workflows` directory. These workflows automate the process of testing and building the backend API whenever changes are pushed to the repository.

The CI process for the GraphQL API includes:
- Running tests
- Linting the Elixir code
- Building the Phoenix application

To view the status of the CI workflows for the GraphQL API, check the "Actions" tab in the GitHub repository.

Note: The frontend Next.js application is not currently included in the CI process. This may be added in future iterations of the project.

## Thoughts

### Why Next.js over LiveView
While Phoenix LiveView is an excellent choice for real-time applications with its server-side rendering capabilities, I chose Next.js for this project for several reasons:

1. Familiarity: I have more experience with React and Next.js, which allow me to develop faster.
2. Rich Ecosystem: The React ecosystem offers a vast array of libraries and tools that I can utilize to enhance the application.
3. Static Generation: Next.js's ability to generate static pages can significantly improve performance for parts of the application that don't require real-time updates.

### Why GraphQL over RESTful API
Choosing GraphQL over a traditional RESTful API was driven by several factors:

1. Flexible Data Fetching: GraphQL allows the frontend to request exactly the data it needs, reducing over-fetching and under-fetching of data.
2. Strong Typing: GraphQL's type system provides clear contracts between the frontend and backend, reducing errors and improving development speed.
3. Single Endpoint: GraphQL's single endpoint approach simplifies API management and versioning compared to multiple REST endpoints.
