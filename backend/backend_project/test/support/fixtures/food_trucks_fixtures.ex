defmodule BackendProject.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendProject.FoodTrucks` context.
  """

  @doc """
  Generate a permit.
  """
  def permit_fixture(attrs \\ %{}) do
    {:ok, permit} =
      attrs
      |> Enum.into(%{
        address: "some address",
        applicant: "some applicant",
        facility_type: "some facility_type",
        food_items: "some food_items",
        latitude: "120.5",
        location: "some location",
        location_description: "some location_description",
        longitude: "120.5",
        status: "some status"
      })
      |> BackendProject.FoodTrucks.create_permit()

    permit
  end
end
