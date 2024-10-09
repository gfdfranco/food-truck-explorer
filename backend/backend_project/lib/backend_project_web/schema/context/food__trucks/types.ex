defmodule BackendProjectWeb.Schema.Context.FoodTrucks.Types do
  use Absinthe.Schema.Notation

  @desc """
  Object representing a food truck.
  This type contains basic information about a food truck.

  ## Fields
  - id: The unique identifier of the food truck
  - applicant: The name of the food truck
  - facility_type: The type of facility of the food truck
  - location_description: The location description of the food truck
  - address: The address of the food truck
  - status: The status of the food truck
  - food_items: The food items of the food truck
  - latitude: The latitude of the food truck
  - longitude: The longitude of the food truck
  """
  object :food_truck do
    field :id, non_null(:id)
    field :applicant, non_null(:string)
    field :facility_type, :string
    field :location_description, :string
    field :address, :string
    field :status, :string
    field :food_items, :string
    field :latitude, :string
    field :longitude, :string
  end
end
