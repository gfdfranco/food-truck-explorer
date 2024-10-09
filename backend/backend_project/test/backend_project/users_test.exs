defmodule BackendProject.UsersTest do
  use BackendProject.DataCase

  alias BackendProject.Users
  alias BackendProject.Users.Favorite
  alias BackendProject.Accounts
  alias BackendProject.FoodTrucks

  import BackendProject.UsersFixtures

  describe "favorites" do
    @invalid_attrs %{user_id: nil, food_truck_id: nil}

    setup do
      # Ensure password is at least 12 characters
      {:ok, user} = Accounts.register_user(%{email: "test@example.com", password: "securepassword123"})

      # Provide all required fields for creating a permit
      {:ok, permit} = FoodTrucks.create_permit(%{
        status: "APPROVED",
        applicant: "Test Truck",
        facility_type: "Truck",
        location_description: "Test location",
        address: "123 Test Street",
        food_items: "Test food items",
        latitude: 37.7749,
        longitude: -122.4194,
        location: "(37.7749, -122.4194)"
      })

      {:ok, user: user, permit: permit}
    end

    test "list_favorites/0 returns all favorites" do
      favorite = favorite_fixture()
      assert Users.list_favorites() == [favorite]
    end

    test "get_favorite!/1 returns the favorite with given id" do
      favorite = favorite_fixture()
      assert Users.get_favorite!(favorite.id) == favorite
    end

    test "create_favorite/1 with valid data creates a favorite", %{user: user, permit: permit} do
      valid_attrs = %{user_id: user.id, food_truck_id: permit.id}

      assert {:ok, %Favorite{} = favorite} = Users.create_favorite(valid_attrs)
      assert favorite.user_id == user.id
      assert favorite.food_truck_id == permit.id
    end

    test "create_favorite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_favorite(@invalid_attrs)
    end

    test "update_favorite/2 with valid data updates the favorite", %{user: user, permit: permit} do
      favorite = favorite_fixture()
      update_attrs = %{user_id: user.id, food_truck_id: permit.id}

      assert {:ok, %Favorite{} = favorite} = Users.update_favorite(favorite, update_attrs)
      assert favorite.user_id == user.id
      assert favorite.food_truck_id == permit.id
    end

    test "update_favorite/2 with invalid data returns error changeset" do
      favorite = favorite_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_favorite(favorite, @invalid_attrs)
      assert favorite == Users.get_favorite!(favorite.id)
    end

    test "delete_favorite/1 deletes the favorite" do
      favorite = favorite_fixture()
      assert {:ok, %Favorite{}} = Users.delete_favorite(favorite)
      assert_raise Ecto.NoResultsError, fn -> Users.get_favorite!(favorite.id) end
    end

    test "change_favorite/1 returns a favorite changeset" do
      favorite = favorite_fixture()
      assert %Ecto.Changeset{} = Users.change_favorite(favorite)
    end
  end
end
