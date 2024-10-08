defmodule BackendProjectWeb.Schema.Context.Accounts.Queries do
  @moduledoc """
  This module contains queries related to user accounts.
  """

  use Absinthe.Schema.Notation
  alias BackendProjectWeb.Schema.Middleware
  alias BackendProjectWeb.Resolvers

  object :account_queries do
    @desc """
    Get the current user.
    This query returns information about the currently authenticated user.

    ## Query
    ```graphql
    query Me {
      me {
        id
        email
        insertedAt
      }
    }
    ```
    """
    field :me, :user do
      middleware Middleware.Authenticate
      resolve &Resolvers.Accounts.me/3
    end

  end
end
