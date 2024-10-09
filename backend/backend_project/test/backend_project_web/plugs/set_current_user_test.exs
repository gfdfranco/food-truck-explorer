defmodule BackendProjectWeb.Plugs.SetCurrentUserTest do
  use BackendProjectWeb.ConnCase, async: true

  alias BackendProjectWeb.Plugs.SetCurrentUser
  alias BackendProject.Accounts

  setup do
    {:ok, user} =
      Accounts.register_user(%{
        email: "test@example.com",
        password: "Password12345678"
      })

    token = Accounts.generate_user_session_token(user)

    {:ok, token: token}
  end

  test "sets token in context when valid token is provided", %{conn: conn, token: token} do
    encoded_token = Base.url_encode64(token, padding: false)
    conn = put_req_header(conn, "authorization", "Bearer " <> encoded_token)

    conn = SetCurrentUser.call(conn, %{})

    assert conn.private[:absinthe][:context] == %{token: encoded_token}
  end

  test "does not set token in context when no token is provided", %{conn: conn} do
    conn = SetCurrentUser.call(conn, %{})

    assert conn.private[:absinthe][:context] == %{}
  end

  test "does not set current_user in context when invalid token is provided", %{conn: conn} do
    conn = put_req_header(conn, "authorization", "Bearer invalid_token")

    conn = SetCurrentUser.call(conn, %{})

    assert conn.private[:absinthe][:context] == %{}
  end
end
