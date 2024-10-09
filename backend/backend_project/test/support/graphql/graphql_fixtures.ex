defmodule BackendProject.GraphQLHelpers do
  @moduledoc """
    Helper functions for working with GraphQL tests.
    """

  def comparison_message do
    fn right, left ->
      right.message == left.message
    end
  end

  def comparison_details_message do
    fn right, left ->
      right.message == left.message
      && right.details == left.details
    end
  end

  def gql_post(query, variables \\ %{}, context \\ %{}) do
    {:ok, response} = Absinthe.run(query, BackendProjectWeb.Schema,
      variables: variables,
      context: context
    )
    response
  end

  def data_on_graphql(response) when is_map(response) do
    response
    |> map_keys_to_atoms()
  end

  def data_on_graphql(response) when is_list(response) do
    response
    |> list_maps_to_atoms()
  end

  def map_keys_to_atoms(m) do
    Enum.into(m, %{}, fn
      {k, v} when is_map(v) ->
        atom = String.downcase(k) |> String.to_atom()
        { atom, map_keys_to_atoms(v) }

      {k, v} when is_list(v) and is_map(hd(v)) ->
        atom = String.downcase(k) |> String.to_atom()
        {atom, list_maps_to_atoms(v)}

      {k, v} when is_binary(k) ->
        atom = String.downcase(k) |> String.to_atom()
        {atom, v}

      entry ->
        entry
    end)
  end

  def list_maps_to_atoms(list) do
    Enum.map(list, &map_keys_to_atoms/1)
  end

end
