defmodule BackendProjectWeb.Resolvers.AccountsTest do
  use BackendProjectWeb.ConnCase, async: true

  import BackendProject.AccountsFixtures
  import BackendProject.GraphQLHelpers

  alias BackendProjectWeb.Schema
  alias BackendProject.Accounts

  @me_query """
  query Me {
    me {
      id
      email
    }
  }
  """

  @signup_mutation """
  mutation SignUp($email: String!, $password: String!) {
    signUp(email: $email, password: $password) {
      user {
        email
      }
      token
    }
  }
  """

  @signin_mutation """
  mutation SignIn($email: String!, $password: String!) {
    signIn(email: $email, password: $password) {
      user {
        email
      }
      token
    }
  }
  """

  @signout_mutation """
  mutation SignOut {
    signOut
  }
  """

  describe "sign_up/3" do
    test "creates a new user account" do
      email = unique_user_email()
      password = valid_user_password()

      response =
        gql_post(
          @signup_mutation,
          %{"email" => email, "password" => password}
        )
        |> get_in([:data, "signUp"])
        |> data_on_graphql()

      assert response.user.email == email
      assert response.token != nil
    end

    test "returns error for invalid input" do
      response =
        gql_post(
          @signup_mutation,
          %{"email" => "invalid", "password" => "short"}
        )

      expected_errors = [
        %{
          message: "Could not create account.",
          details: %{
            password: ["should be at least 12 character(s)"],
            email: ["must have the @ sign and no spaces"]
          }
        }
      ]

      assert length(response.errors) == length(expected_errors)
      Enum.zip(response.errors, expected_errors) |> Enum.each(fn {actual, expected} ->
        assert actual.message == expected.message
        assert actual.details == expected.details
      end)
    end

    # ... other sign_up tests (duplicate email, invalid password, etc.) ...
  end

  describe "sign_in/3" do
    test "signs in a user with valid credentials" do
      user = user_fixture()

      response =
        gql_post(
          @signin_mutation,
          %{"email" => user.email, "password" => valid_user_password()}
        )
        |> get_in([:data, "signIn"])
        |> data_on_graphql()

      assert response.user.email == user.email
      assert response.token != nil
    end

    test "returns error for invalid credentials" do
      user = user_fixture()

      response =
        gql_post(
          @signin_mutation,
          %{"email" => user.email, "password" => "wrongpassword"}
        )

      assert [%{message: "Credentials are invalid."}] = response.errors
    end
  end

  describe "sign_out/3" do
    setup do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      %{user: user, token: token}
    end

    test "signs out a user", %{token: token} do
      encoded_token = Base.url_encode64(token, padding: false)

      gql_post(
        @signout_mutation,
        %{},
        %{token: encoded_token}
      )

      assert BackendProject.Accounts.get_user_by_session_token(token) == nil
    end
  end

  describe "sign_in and sign_out" do
    test "user can sign in and then sign out" do
      user = user_fixture()
      password = valid_user_password()

      signin_response =
        gql_post(@signin_mutation, %{
          "email" => user.email,
          "password" => password
        }).data["signIn"]
        |> data_on_graphql()

      assert signin_response.user.email == user.email
      assert signin_response.token != nil

      signout_response =
        gql_post(@signout_mutation, %{}, %{token: signin_response.token}).data["signOut"]

      assert signout_response == signin_response.token

      me_response = gql_post(@me_query, %{}, %{token: signin_response.token}).data["me"]

      assert me_response == nil
    end
  end
end
