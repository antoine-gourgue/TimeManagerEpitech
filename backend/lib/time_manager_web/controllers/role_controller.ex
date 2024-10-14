defmodule TimeManagerWeb.RoleController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.Role

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    roles = Accounts.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def show(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def create(conn, %{"role" => role_params}) do
    case Accounts.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/roles/#{role.id}")
        |> render("show.json", role: role)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Accounts.get_role!(id)

    case Accounts.update_role(role, role_params) do
      {:ok, role} ->
        render(conn, "show.json", role: role)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)

    with {:ok, _role} <- Accounts.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
