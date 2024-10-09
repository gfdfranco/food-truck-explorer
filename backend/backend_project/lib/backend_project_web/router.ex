defmodule BackendProjectWeb.Router do
  use BackendProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BackendProjectWeb.Plugs.SetCurrentUser
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: BackendProjectWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: BackendProjectWeb.Schema,
        interface: :advanced
    end
  end
end
