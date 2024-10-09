defmodule BackendProjectWeb.Schema.Middleware.Authenticate do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do

    case resolution.context do
      %{token: token} ->
        with {:ok, decoded_token} <- Base.url_decode64(token, padding: false) do
              case BackendProject.Accounts.get_user_by_session_token(decoded_token) do
                %BackendProject.Accounts.User{} = _ ->
                  resolution
                nil ->
                  resolution
                  |> Absinthe.Resolution.put_result({:error, "The session is invalid!"})
              end
        end
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "Please sign in first!"})
    end
  end
end
