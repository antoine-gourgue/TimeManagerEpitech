defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeEntries
  alias TimeManager.Tracking.Clock

  action_fallback TimeManagerWeb.FallbackController

  # GET /api/clocks
  def index(conn, _params) do
    clocks = TimeEntries.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  # GET /api/clocks/:id
  def show(conn, %{"id" => id}) do
    clock = TimeEntries.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  # POST /api/clocks
  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- TimeEntries.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", "/api/clocks/#{clock.id}")
      |> render("show.json", clock: clock)
    end
  end

  # PATCH/PUT /api/clocks/:id
  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = TimeEntries.get_clock!(id)

    with {:ok, %Clock{} = updated_clock} <- TimeEntries.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: updated_clock)
    end
  end

  # DELETE /api/clocks/:id
  def delete(conn, %{"id" => id}) do
    clock = TimeEntries.get_clock!(id)

    with {:ok, %Clock{}} <- TimeEntries.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  # GET /api/clocks/users/:user_id
  def index_for_user(conn, %{"user_id" => user_id}) do
    clocks = TimeEntries.list_clocks_for_user(user_id)
    render(conn, "index.json", clocks: clocks)
  end
end
