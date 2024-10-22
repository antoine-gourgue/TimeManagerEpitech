defmodule TimeManagerWeb.WorkingTimeControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TrackingFixtures

  alias TimeManagerWeb.Router.Helpers, as: Routes


  alias TimeManager.Tracking.WorkingTime

  @valid_attrs %{type: "some type", start_time: ~N[2024-10-13 12:16:00], end_time: ~N[2024-10-14 12:16:00]}
  @invalid_attrs %{type: nil, start_time: nil, end_time: nil}

  describe "index" do
    test "lists all working times", %{conn: conn} do
      conn = get(conn, Routes.working_time_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create working time" do
    test "renders working time when data is valid", %{conn: conn} do
      conn = post(conn, Routes.working_time_path(conn, :create), working_time: @valid_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.working_time_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "type" => "some type",
               "start_time" => "2024-10-13T12:16:00",
               "end_time" => "2024-10-14T12:16:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.working_time_path(conn, :create), working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working time" do
    setup [:create_working_time]

    test "renders working time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id} = working_time} do
      conn = put(conn, Routes.working_time_path(conn, :update, working_time), working_time: @valid_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = put(conn, Routes.working_time_path(conn, :update, working_time), working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working time" do
    setup [:create_working_time]

    test "deletes chosen working time", %{conn: conn, working_time: working_time} do
      conn = delete(conn, Routes.working_time_path(conn, :delete, working_time))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.working_time_path(conn, :show, working_time))
      end
    end
  end

  defp create_working_time(_) do
    working_time = working_time_fixture()
    %{working_time: working_time}
  end
end
