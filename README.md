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

## Project Structure
```
food-truck-explorer/
├── backend/           # Phoenix GraphQL API
├── frontend/          # Next.js web application
└── README.md          # This file
```

For specific setup and configuration instructions, please refer to the README files in the `backend/` and `frontend/` directories.

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
