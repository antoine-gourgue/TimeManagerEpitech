defmodule TimeManagerWeb.RoleJSON do
  alias TimeManager.Accounts.Role

  @doc """
  Renders a list of roles.
  """
  def index(%{roles: roles}) do
    %{data: for(role <- roles, do: data(role))}
  end

  @doc """
  Renders a single role.
  """
  def show(%{role: role}) do
    %{data: data(role)}
  end

  defp data(%Role{} = role) do
    %{
      id: role.id,
      name: role.name,
      inserted_at: role.inserted_at,
      updated_at: role.updated_at
    }
  end
end
