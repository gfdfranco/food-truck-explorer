defmodule BackendProject.Users.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do

    field :user_id, :id
    field :food_truck_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [])
    |> validate_required([])
  end
end
