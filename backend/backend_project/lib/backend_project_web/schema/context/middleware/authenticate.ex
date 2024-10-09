defmodule BackendProjectWeb.Schema.Middleware.Authenticate do
  @behaviour Absinthe.Middleware

  alias BackendProject.Accounts

  def call(resolution, _) do
    case resolution.context do
      %{token: token} ->
        with {:ok, decoded_token} <- Base.url_decode64(token, padding: false),
             user when not is_nil(user) <- Accounts.get_user_by_session_token(decoded_token) do
          Map.update!(resolution, :context, fn ctx ->
            Map.put(ctx, :current_user, user)
          end)
        else
          _ -> Absinthe.Resolution.put_result(resolution, {:error, "The session is invalid!"})
        end
      _ ->
        Absinthe.Resolution.put_result(resolution, {:error, "Please sign in first!"})
    end
  end
end
