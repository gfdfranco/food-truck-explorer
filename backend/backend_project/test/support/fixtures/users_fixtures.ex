defmodule BackendProject.UsersFixtures do
  alias BackendProject.Accounts
  alias BackendProject.FoodTrucks

  def favorite_fixture(attrs \\ %{}) do
    user = user_fixture()
    permit = BackendProject.FoodTrucksFixtures.permit_fixture()

    {:ok, favorite} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        food_truck_id: permit.id
      })
      |> BackendProject.Users.create_favorite()

    favorite
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "user#{System.unique_integer([:positive])}@example.com",
        password: "securepassword123##"
      })
      |> Accounts.register_user()

    user
  end
end
