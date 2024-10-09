defmodule BackendProject.Repo.Migrations.IncreaseFieldLengths do
  use Ecto.Migration

  def change do
    alter table(:permits) do
      modify :food_items, :text
      modify :location_description, :text
    end
  end
end
