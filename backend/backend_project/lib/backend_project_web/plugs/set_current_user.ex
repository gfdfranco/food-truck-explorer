defmodule BackendProjectWeb.Plugs.SetCurrentUser do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok, decoded_token} <- Base.url_decode64(token, padding: false),
        {:ok, _verify_session} <- BackendProject.Accounts.UserToken.verify_session_token_query(decoded_token) do
      %{token: token}
    else
      _ -> %{}
    end
  end

end
