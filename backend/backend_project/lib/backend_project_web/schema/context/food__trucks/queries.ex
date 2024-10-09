defmodule BackendProjectWeb.Schema.Context.FoodTrucks.Queries do
  use Absinthe.Schema.Notation
  alias BackendProject.Repo
  alias BackendProject.FoodTrucks.Permit
  import Ecto.Query

  object :food_truck_queries do
    @desc """
    Get all food trucks.
    This query returns a list of all available food trucks, with optional pagination.

    ## Arguments
    - limit: The maximum number of food trucks to return (optional)
    - offset: The number of food trucks to skip (optional)

    ## Query
    ```graphql
    query FoodTrucks($limit: Int, $offset: Int) {
      foodTrucks(limit: $limit, offset: $offset) {
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

    ## Example Variables
    ```json
    {
      "limit": 10,
      "offset": 0
    }
    ```
    """
    field :food_trucks, list_of(:food_truck) do
      arg :limit, :integer
      arg :offset, :integer

      resolve fn _, args, _ ->
        query = from(p in Permit, order_by: [asc: p.inserted_at])

        query = if args[:limit], do: limit(query, ^args.limit), else: query
        query = if args[:offset], do: offset(query, ^args.offset), else: query

        {:ok, Repo.all(query)}
      end
    end
  end
end
