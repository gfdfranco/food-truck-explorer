defmodule BackendProjectWeb.Schema.Context.Accounts.Types do
  @moduledoc """
  This module defines GraphQL types related to user accounts, including session and user objects.
  """

  use Absinthe.Schema.Notation

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
  - inserted_at: The timestamp when the user was created

  ## Example
  ```graphql
    user {
      id
      email
      role
      insertedAt
    }
  ```
  """
  object :user do
    field :id, :id
    field :email, :string
    field :inserted_at, :string
  end
end
