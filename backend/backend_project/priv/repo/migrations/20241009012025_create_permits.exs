defmodule BackendProject.Repo.Migrations.CreatePermits do
  use Ecto.Migration

  def change do
    create table(:permits) do
      add :applicant, :string
      add :facility_type, :string
      add :location_description, :string
      add :address, :string
      add :status, :string
      add :food_items, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :location, :string

      timestamps(type: :utc_datetime)
    end
  end
end
