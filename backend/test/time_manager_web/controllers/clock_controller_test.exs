defmodule TimeManagerWeb.ClockControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TrackingFixtures
  import TimeManagerWeb.ConnCaseHelper # Helper pour authentification

  alias TimeManager.Tracking.Clock
  alias TimeManagerWeb.Router.Helpers, as: Routes

  @valid_attrs %{status: "running", time: ~N[2024-10-13 12:17:00]}
  @update_attrs %{status: "stopped", time: ~N[2024-10-14 12:17:00]}
  @invalid_attrs %{status: nil, time: nil}

  describe "index" do
    test "lists all clocks", %{conn: conn} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> get(Routes.clock_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create clock" do
    test "renders clock when data is valid", %{conn: conn} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> post(Routes.clock_path(conn, :create), clock: @valid_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "status" => "running",
               "time" => "2024-10-13T12:17:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> post(Routes.clock_path(conn, :create), clock: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update clock" do
    setup [:create_clock]

    test "renders clock when data is valid", %{conn: conn, clock: %Clock{id: id} = clock} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> put(Routes.clock_path(conn, :update, clock), clock: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.clock_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "status" => "stopped",
               "time" => "2024-10-14T12:17:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, clock: clock} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> put(Routes.clock_path(conn, :update, clock), clock: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete clock" do
    setup [:create_clock]

    test "deletes chosen clock", %{conn: conn, clock: clock} do
      conn = conn
             |> authenticate_conn() # Ajout du token JWT
             |> delete(Routes.clock_path(conn, :delete, clock))

      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.clock_path(conn, :show, clock))
      end
    end
  end

  # Helper pour créer une instance clock
  defp create_clock(_) do
    clock = clock_fixture()
    %{clock: clock}
  end
end
