defmodule BackendProjectWeb.Schema.Context.Accounts.Types do
  @moduledoc """
  This module defines GraphQL types related to user accounts, including session and user objects.
  """

  use Absinthe.Schema.Notation
  alias BackendProject.Repo
  import Ecto.Query

  import BackendProjectWeb.Schema.Context.FoodTrucks.Types

  @desc """
  Object representing a user session.
  This type is typically returned after successful authentication.

  ## Fields
  - user: The authenticated user (non-null)
  - token: The authentication token (non-null)

  ## Example
  ```graphql
    session {
      user {
        id
        email
      }
      token
    }
  ```
  """
  object :session do
    field :user, non_null(:user)
    field :token, non_null(:string)
  end

  @desc """
  Object representing a user.
  This type contains basic information about a user account.

  ## Fields
  - id: The unique identifier of the user
  - email: The user's email address
  - role: The user's role in the system
  - favorite_places: A list of the user's favorite food truck places
  - inserted_at: The timestamp when the user was created

  ## Example
  ```graphql
      user {
        id
        email
        favoritePlaces {
          id
          applicant
          facilityType
          locationDescription
          address
          status
          foodItems
          latitude
          longitude
        }
      }
  ```

  """
  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :inserted_at, non_null(:string)

    field :favorite_places, list_of(:food_truck) do
      resolve fn user, _, _ ->
        query = from p in BackendProject.FoodTrucks.Permit,
                join: f in BackendProject.Users.Favorite,
                on: f.food_truck_id == p.id,
                where: f.user_id == ^user.id,
                order_by: [asc: p.inserted_at],
                select: p

        # Add debugging
        IO.inspect(query, label: "Generated Query")

        result = Repo.all(query)
        IO.inspect(result, label: "Query Result")

        {:ok, result}
      end
    end
  end
end
