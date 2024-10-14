defmodule TimeManager.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password",
        username: "some username"
      })
      |> TimeManager.Accounts.create_user()

    user
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TimeManager.Accounts.create_role()

    role
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TimeManager.Accounts.create_team()

    team
  end

  @doc """
  Generate a user_team.
  """
  def user_team_fixture(attrs \\ %{}) do
    {:ok, user_team} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.Accounts.create_user_team()

    user_team
  end
end
