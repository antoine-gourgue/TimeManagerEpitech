defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeEntries
  alias TimeManager.TimeEntries.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    working_times = TimeEntries.list_working_times()
    render(conn, "index.json", working_times: working_times)
  end

  def show(conn, %{"id" => id}) do
    working_time = TimeEntries.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    case TimeEntries.create_working_time(working_time_params) do
      {:ok, working_time} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
        |> render("show.json", working_time: working_time)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeEntries.get_working_time!(id)

    case TimeEntries.update_working_time(working_time, working_time_params) do
      {:ok, working_time} ->
        render(conn, "show.json", working_time: working_time)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = TimeEntries.get_working_time!(id)

    with {:ok, _working_time} <- TimeEntries.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
