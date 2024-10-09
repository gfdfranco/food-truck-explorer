defmodule BackendProject.Users.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do

    belongs_to :user, BackendProject.Users.User
    belongs_to :food_truck, BackendProject.FoodTrucks.Permit, foreign_key: :food_truck_id

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:user_id, :food_truck_id])
    |> validate_required([:user_id, :food_truck_id])
    |> unique_constraint([:user_id, :food_truck_id])
  end
end
