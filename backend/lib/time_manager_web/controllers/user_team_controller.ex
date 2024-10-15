defmodule TimeManagerWeb.UserTeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.UserTeam

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    user_teams = Accounts.list_user_teams()
    render(conn, "index.json", user_teams: user_teams)
  end

  def create(conn, %{"user_team" => user_team_params}) do
    with {:ok, %UserTeam{} = user_team} <- Accounts.create_user_team(user_team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/user_teams/#{user_team.id}")
      |> render("show.json", user_team: user_team)
    end
  end

  def show(conn, %{"id" => id}) do
    user_team = Accounts.get_user_team!(id)
    render(conn, "show.json", user_team: user_team)
  end

  def update(conn, %{"id" => id, "user_team" => user_team_params}) do
    user_team = Accounts.get_user_team!(id)

    with {:ok, %UserTeam{} = user_team} <- Accounts.update_user_team(user_team, user_team_params) do
      render(conn, "show.json", user_team: user_team)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_team = Accounts.get_user_team!(id)

    with {:ok, %UserTeam{}} <- Accounts.delete_user_team(user_team) do
      send_resp(conn, :no_content, "")
    end
  end
end
