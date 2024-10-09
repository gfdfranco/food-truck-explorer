defmodule BackendProjectWeb.Resolvers.Accounts do
  alias BackendProject.Accounts
  alias BackendProjectWeb.UserAuth
  alias BackendProject.Accounts.User
  alias BackendProject.Users
  alias BackendProject.FoodTrucks.Permit
  alias BackendProject.Users.Favorite

  import Ecto.Query
  alias BackendProject.Repo
  alias BackendProjectWeb.Schema.ChangesetErrors

  def me(_, _, %{context: %{token: token}}) do
    with {:ok, decoded_token} <- Base.url_decode64(token, padding: false) do
      case Accounts.get_user_by_session_token(decoded_token) do
        %User{} = user ->
          {:ok, user}
        nil ->
          {:ok, nil}
      end
    else
      _ ->
        {:ok, nil}
    end
  end

  def me(_, _, _)do
    {:ok, nil}
  end

  def sign_up(_, %{email: email, password: password}, _)do
    case Accounts.register_user(%{email: email, password: password}) do
      {:ok, user} ->
        token = BackendProject.Accounts.generate_user_session_token(user)

        {:ok, %{user: user, token: Base.url_encode64(token, padding: false)}}
      {:error, %Ecto.Changeset{} = changeset} ->
        {
          :error,
          message: "Could not create account.",
          details: ChangesetErrors.error_details(changeset)
        }
    end
  end

  def sign_in(_, %{email: email, password: password}, _)do
    case Accounts.get_user_by_email_and_password(email, password) do
      %User{} = user ->
        token = BackendProject.Accounts.generate_user_session_token(user)

        {:ok, %{user: user, token: Base.url_encode64(token, padding: false)}}
      nil ->
        {
          :error,
          message: "Credentials are invalid."
        }
    end
  end

  def sign_out(_, _, %{context: %{token: token}}) do
    with {:ok, decoded_token} <- Base.url_decode64(token, padding: false) do
      BackendProject.Accounts.delete_user_session_token(decoded_token)
    end
    {:ok, token}
  end

  def add_favorite_food_truck(_parent, %{food_truck_id: food_truck_id}, %{context: %{current_user: user}}) do
    with {id, _} <- Integer.parse(food_truck_id),
         %Permit{} = food_truck <- Repo.get(Permit, id) do

      favorite_changeset = Ecto.build_assoc(user, :favorites, food_truck_id: food_truck.id)

      case Repo.insert(favorite_changeset) do
        {:ok, _favorite} ->
          {:ok, user}
        {:error, changeset} ->
          {:error, "Could not add favorite food truck: #{inspect(changeset.errors)}"}
      end
    else
      :error ->
        {:error, "Invalid food truck ID"}
      nil ->
        {:error, "Food truck not found"}
    end
  end

  def add_favorite_food_truck(_, _, _) do
    {:error, "Authentication required"}
  end
end
