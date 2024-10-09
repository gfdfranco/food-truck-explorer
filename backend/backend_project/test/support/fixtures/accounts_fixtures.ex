defmodule BackendProject.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackendProject.Accounts` context.
  """

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "Hello_world_1"
  def valid_user_email, do: "email@unique.com"
  def invalid_user_email, do: "user"
  def invalid_user_password, do: "sp"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> BackendProject.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  def extract_token(email) do
    email.text_body
    |> String.split("\n")
    |> Enum.find(&String.contains?(&1, "some_url"))
    |> String.split("/")
    |> List.last()
    |> String.trim()
  end
end
