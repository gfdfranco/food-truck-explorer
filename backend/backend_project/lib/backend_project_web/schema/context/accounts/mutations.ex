defmodule BackendProjectWeb.Schema.Context.Accounts.Mutations do
  @moduledoc """
  This module contains mutations related to user accounts, including sign up, sign in and sign out.
  """

  use Absinthe.Schema.Notation
  alias BackendProjectWeb.Resolvers
  alias BackendProjectWeb.Schema.Middleware

  object :account_mutations do
    @desc """
    Create a user account.
    This mutation allows the creation of a new user account and returns a session.

    ## Mutation
    ```graphql
    mutation SignUp($email: String!, $password: String!) {
      signUp(email: $email, password: $password) {
        token
        user {
          id
          email
        }
      }
    }
    ```
    ## Variables
    ```json
    {
      "email": "user@example.com",
      "password": "securepassword"
    }
    ```
    """
    field :sign_up, :session do
      arg :email, :string
      arg :password, :string
      resolve &Resolvers.Accounts.sign_up/3
    end

    @desc """
    Sign in a user.
    This mutation authenticates a user and returns a session.

    ## Mutation
    ```graphql
    mutation SignIn($email: String!, $password: String!) {
      signIn(email: $email, password: $password) {
        token
        user {
          id
          email
        }
      }
    }
    ```
    ## Variables
    ```json
    {
      "email": "user@example.com",
      "password": "securepassword"
    }
    ```
    """
    field :sign_in, :session do
      arg :email, :string
      arg :password, :string
      resolve &Resolvers.Accounts.sign_in/3
    end

    @desc """
    Sign out a user.
    This mutation ends the current user session.

    ## Mutation
    ```graphql
    mutation SignOut {
      signOut
    }
    ```
    """
    field :sign_out, :string do
      middleware Middleware.Authenticate
      resolve &Resolvers.Accounts.sign_out/3
    end

  end
end
