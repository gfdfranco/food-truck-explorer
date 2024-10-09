defmodule BackendProject.FoodTrucksTest do
  use BackendProject.DataCase

  alias BackendProject.FoodTrucks

  describe "permits" do
    alias BackendProject.FoodTrucks.Permit

    import BackendProject.FoodTrucksFixtures

    @invalid_attrs %{status: nil, address: nil, location: nil, applicant: nil, facility_type: nil, location_description: nil, food_items: nil, latitude: nil, longitude: nil}

    test "list_permits/0 returns all permits" do
      permit = permit_fixture()
      assert FoodTrucks.list_permits() == [permit]
    end

    test "get_permit!/1 returns the permit with given id" do
      permit = permit_fixture()
      assert FoodTrucks.get_permit!(permit.id) == permit
    end

    test "create_permit/1 with valid data creates a permit" do
      valid_attrs = %{status: "some status", address: "some address", location: "some location", applicant: "some applicant", facility_type: "some facility_type", location_description: "some location_description", food_items: "some food_items", latitude: "120.5", longitude: "120.5"}

      assert {:ok, %Permit{} = permit} = FoodTrucks.create_permit(valid_attrs)
      assert permit.status == "some status"
      assert permit.address == "some address"
      assert permit.location == "some location"
      assert permit.applicant == "some applicant"
      assert permit.facility_type == "some facility_type"
      assert permit.location_description == "some location_description"
      assert permit.food_items == "some food_items"
      assert permit.latitude == Decimal.new("120.5")
      assert permit.longitude == Decimal.new("120.5")
    end

    test "create_permit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodTrucks.create_permit(@invalid_attrs)
    end

    test "update_permit/2 with valid data updates the permit" do
      permit = permit_fixture()
      update_attrs = %{status: "some updated status", address: "some updated address", location: "some updated location", applicant: "some updated applicant", facility_type: "some updated facility_type", location_description: "some updated location_description", food_items: "some updated food_items", latitude: "456.7", longitude: "456.7"}

      assert {:ok, %Permit{} = permit} = FoodTrucks.update_permit(permit, update_attrs)
      assert permit.status == "some updated status"
      assert permit.address == "some updated address"
      assert permit.location == "some updated location"
      assert permit.applicant == "some updated applicant"
      assert permit.facility_type == "some updated facility_type"
      assert permit.location_description == "some updated location_description"
      assert permit.food_items == "some updated food_items"
      assert permit.latitude == Decimal.new("456.7")
      assert permit.longitude == Decimal.new("456.7")
    end

    test "update_permit/2 with invalid data returns error changeset" do
      permit = permit_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodTrucks.update_permit(permit, @invalid_attrs)
      assert permit == FoodTrucks.get_permit!(permit.id)
    end

    test "delete_permit/1 deletes the permit" do
      permit = permit_fixture()
      assert {:ok, %Permit{}} = FoodTrucks.delete_permit(permit)
      assert_raise Ecto.NoResultsError, fn -> FoodTrucks.get_permit!(permit.id) end
    end

    test "change_permit/1 returns a permit changeset" do
      permit = permit_fixture()
      assert %Ecto.Changeset{} = FoodTrucks.change_permit(permit)
    end
  end
end
