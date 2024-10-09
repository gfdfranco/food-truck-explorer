defmodule BackendProject.FoodTrucks do
  @moduledoc """
  The FoodTrucks context.
  """

  import Ecto.Query, warn: false
  alias BackendProject.Repo

  alias BackendProject.FoodTrucks.Permit

  @doc """
  Returns the list of permits.

  ## Examples

      iex> list_permits()
      [%Permit{}, ...]

  """
  def list_permits do
    Repo.all(Permit)
  end

  @doc """
  Gets a single permit.

  Raises `Ecto.NoResultsError` if the Permit does not exist.

  ## Examples

      iex> get_permit!(123)
      %Permit{}

      iex> get_permit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_permit!(id), do: Repo.get!(Permit, id)

  @doc """
  Creates a permit.

  ## Examples

      iex> create_permit(%{field: value})
      {:ok, %Permit{}}

      iex> create_permit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_permit(attrs \\ %{}) do
    %Permit{}
    |> Permit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a permit.

  ## Examples

      iex> update_permit(permit, %{field: new_value})
      {:ok, %Permit{}}

      iex> update_permit(permit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_permit(%Permit{} = permit, attrs) do
    permit
    |> Permit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a permit.

  ## Examples

      iex> delete_permit(permit)
      {:ok, %Permit{}}

      iex> delete_permit(permit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_permit(%Permit{} = permit) do
    Repo.delete(permit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking permit changes.

  ## Examples

      iex> change_permit(permit)
      %Ecto.Changeset{data: %Permit{}}

  """
  def change_permit(%Permit{} = permit, attrs \\ %{}) do
    Permit.changeset(permit, attrs)
  end
end
