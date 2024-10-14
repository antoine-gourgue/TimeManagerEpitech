defmodule TimeManager.Teams do
  alias TimeManager.Repo
  alias TimeManager.Accounts.Team

  @doc """
  Renvoie toutes les équipes.
  """
  def list_teams do
    Repo.all(Team)
  end
end
