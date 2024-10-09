defmodule BackendProject.FoodTrucks.Permit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permits" do
    field :status, :string
    field :address, :string
    field :location, :string
    field :applicant, :string
    field :facility_type, :string
    field :location_description, :string
    field :food_items, :string
    field :latitude, :decimal
    field :longitude, :decimal

    has_many :favorites, BackendProject.Users.Favorite
    has_many :users, through: [:favorites, :user]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permit, attrs) do
    permit
    |> cast(attrs, [:applicant, :facility_type, :location_description, :address, :status, :food_items, :latitude, :longitude, :location])
    |> validate_required([:applicant, :facility_type, :location_description, :address, :status, :food_items, :latitude, :longitude, :location])
  end
end
