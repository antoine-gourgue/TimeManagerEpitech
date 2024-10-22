defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Teams
  alias TimeManager.Account.Team

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = Teams.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def create(conn, %{"team" => team_params}) do
    case Teams.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.team_path(conn, :show, team))
        |> render("show.json", team: team)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    case Teams.update_team(team, team_params) do
      {:ok, team} ->
        render(conn, "show.json", team: team)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    with {:ok, _team} <- Teams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def list_users(conn, %{"team_id" => team_id}) do
    users = Teams.get_users_for_team(team_id)
    render(conn, "index.json", users: users)
  end
end
