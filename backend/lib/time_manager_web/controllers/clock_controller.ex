defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Clock
  alias TimeManager.Clock.Entry

  action_fallback TimeManagerWeb.FallbackController

  def clock_in(conn, %{"user_id" => user_id}) do
    case Clock.clock_in(user_id) do
      {:ok, clock} ->
        conn
        |> put_status(:created)
        |> render("show.json", clock: clock)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def clock_out(conn, %{"user_id" => user_id}) do
    case Clock.clock_out(user_id) do
      {:ok, clock} ->
        render(conn, "show.json", clock: clock)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
