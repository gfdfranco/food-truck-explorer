defmodule BackendProjectWeb.Router do
  use BackendProjectWeb, :router

  import BackendProjectWeb.UserAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendProjectWeb do
    pipe_through :api
  end

end
