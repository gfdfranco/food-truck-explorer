defmodule BackendProject.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users, on_delete: :nothing)
      add :food_truck_id, references(:permits, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:favorites, [:user_id])
    create index(:favorites, [:food_truck_id])
  end
end
