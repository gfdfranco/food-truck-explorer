defmodule BackendProjectWeb.Schema.Middleware.AuthenticationTest do
  use BackendProjectWeb.ConnCase, async: true

  alias BackendProjectWeb.Schema.Middleware.Authenticate
  alias BackendProject.Accounts

  import BackendProject.AccountsFixtures

  describe "Authenticate middleware" do
    setup do
      user = user_fixture()
      token = Accounts.generate_user_session_token(user)
      encoded_token = Base.url_encode64(token, padding: false)
      %{conn: build_conn(), user: user, token: token, encoded_token: encoded_token}
    end

    test "sets token in context when valid token is provided", %{
      encoded_token: encoded_token
    } do
      resolution = %Absinthe.Resolution{context: %{token: encoded_token}}
      result = Authenticate.call(resolution, %{})
      assert result.context == %{token: encoded_token}
    end

    test "does not set token in context when no token is provided" do
      resolution = %Absinthe.Resolution{context: %{}}
      result = Authenticate.call(resolution, %{})
      assert result.errors == ["Please sign in first!"]
    end

    test "handles invalid Base64 token" do
      invalid_token = "invalid_base64_token"
      resolution = %Absinthe.Resolution{context: %{token: invalid_token}}
      result = Authenticate.call(resolution, %{})

      assert result.errors == ["The session is invalid!"]
    end
  end
end
