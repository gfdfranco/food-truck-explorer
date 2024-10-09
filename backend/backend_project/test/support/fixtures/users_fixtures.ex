defmodule BackendProject.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendProject.Users` context.
  """

  @doc """
  Generate a favorite.
  """
  def favorite_fixture(attrs \\ %{}) do
    {:ok, favorite} =
      attrs
      |> Enum.into(%{

      })
      |> BackendProject.Users.create_favorite()

    favorite
  end
end
