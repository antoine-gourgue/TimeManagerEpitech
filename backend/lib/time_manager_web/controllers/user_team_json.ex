defmodule TimeManagerWeb.UserTeamJSON do
  alias TimeManager.Accounts.UserTeam

  @doc """
  Renders a list of user_teams.
  """
  def index(%{user_teams: user_teams}) do
    %{data: for(user_team <- user_teams, do: data(user_team))}
  end

  @doc """
  Renders a single user_team.
  """
  def show(%{user_team: user_team}) do
    %{data: data(user_team)}
  end

  defp data(%UserTeam{} = user_team) do
    %{
      id: user_team.id,
      user_id: user_team.user_id,
      team_id: user_team.team_id,
      inserted_at: user_team.inserted_at,
      updated_at: user_team.updated_at
    }
  end
end
