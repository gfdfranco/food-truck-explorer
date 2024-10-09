defmodule BackendProject.UsersTest do
  use BackendProject.DataCase

  alias BackendProject.Users

  describe "favorites" do
    alias BackendProject.Users.Favorite

    import BackendProject.UsersFixtures

    @invalid_attrs %{}

    test "list_favorites/0 returns all favorites" do
      favorite = favorite_fixture()
      assert Users.list_favorites() == [favorite]
    end

    test "get_favorite!/1 returns the favorite with given id" do
      favorite = favorite_fixture()
      assert Users.get_favorite!(favorite.id) == favorite
    end

    test "create_favorite/1 with valid data creates a favorite" do
      valid_attrs = %{}

      assert {:ok, %Favorite{} = favorite} = Users.create_favorite(valid_attrs)
    end

    test "create_favorite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_favorite(@invalid_attrs)
    end

    test "update_favorite/2 with valid data updates the favorite" do
      favorite = favorite_fixture()
      update_attrs = %{}

      assert {:ok, %Favorite{} = favorite} = Users.update_favorite(favorite, update_attrs)
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
