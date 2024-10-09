defmodule BackendProjectWeb.Schema do
  use Absinthe.Schema
  #Types
  import_types BackendProjectWeb.Schema.Context.Accounts.Types
  import_types BackendProjectWeb.Schema.Context.FoodTrucks.Types

  #Queries
  import_types BackendProjectWeb.Schema.Context.Accounts.Queries
  import_types BackendProjectWeb.Schema.Context.FoodTrucks.Queries

  #Mutations
  import_types BackendProjectWeb.Schema.Context.Accounts.Mutations

  query do
    import_fields :account_queries
    import_fields :food_truck_queries

    # Health Check
    @desc """
    Health check query to verify the service is operational.
    This query provides information about the current status of the service, including its operational status, version, and current timestamp.

    ## Example Query
    ```graphql
    query HealthCheck {
      healthCheck {
        status
        version
        timestamp
      }
    }
    ```

    ## Example Response
    ```json
    {
      "data": {
        "healthCheck": {
          "status": "operational",
          "version": "0.1.0",
          "timestamp": "2023-04-14T12:34:56.789Z"
        }
      }
    }
    ```
    """
    field :health_check, :health_status do
      resolve(&health_check_resolver/3)
    end
  end

  mutation do
    import_fields :account_mutations
  end

  @desc """
  Represents the health status of the backend service.
  """
  object :health_status do
    @desc "The current operational status of the service."
    field :status, non_null(:string)

    @desc "The current version of the backend service."
    field :version, non_null(:string)

    @desc "The current UTC timestamp when the health check was performed (ISO 8601 format)."
    field :timestamp, non_null(:string)
  end

  def health_check_resolver(_, _, _) do
    {:ok, %{
      status: "operational",
      version: BackendProject.MixProject.project()[:version],
      timestamp: DateTime.utc_now() |> DateTime.to_iso8601()
    }}
  end
end
