defmodule BackendProject.Repo do
  use Ecto.Repo,
    otp_app: :backend_project,
    adapter: Ecto.Adapters.Postgres
end
