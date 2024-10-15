defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeEntries
  alias TimeManager.Tracking.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  # GET /api/working_times
  def index(conn, _params) do
    working_times = TimeEntries.list_working_times()
    render(conn, "index.json", working_times: working_times)
  end

  # GET /api/working_times/:id
  def show(conn, %{"id" => id}) do
    working_time = TimeEntries.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  # POST /api/working_times
  def create(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- TimeEntries.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", "/api/working_times/#{working_time.id}")
      |> render("show.json", working_time: working_time)
    end
  end

  # PATCH/PUT /api/working_times/:id
  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = TimeEntries.get_working_time!(id)

    with {:ok, %WorkingTime{} = updated_working_time} <- TimeEntries.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: updated_working_time)
    end
  end

  # DELETE /api/working_times/:id
  def delete(conn, %{"id" => id}) do
    working_time = TimeEntries.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- TimeEntries.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

  # GET /api/working_times/users/:user_id
  def index_for_user(conn, %{"user_id" => user_id}) do
    working_times = TimeEntries.list_working_times_for_user(user_id)
    render(conn, "index.json", working_times: working_times)
  end
end
