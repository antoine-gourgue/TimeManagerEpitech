defmodule TimeManagerWeb.WorkingTimeControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TrackingFixtures

  alias TimeManager.Tracking.WorkingTime

  @create_attrs %{
    type: "some type",
    start_time: ~N[2024-10-13 12:16:00],
    end_time: ~N[2024-10-13 12:16:00]
  }
  @update_attrs %{
    type: "some updated type",
    start_time: ~N[2024-10-14 12:16:00],
    end_time: ~N[2024-10-14 12:16:00]
  }
  @invalid_attrs %{type: nil, start_time: nil, end_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all working_times", %{conn: conn} do
      conn = get(conn, ~p"/api/working_times")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create working_time" do
    test "renders working_time when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/working_times", working_time: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/working_times/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2024-10-13T12:16:00",
               "start_time" => "2024-10-13T12:16:00",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/working_times", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update working_time" do
    setup [:create_working_time]

    test "renders working_time when data is valid", %{conn: conn, working_time: %WorkingTime{id: id} = working_time} do
      conn = put(conn, ~p"/api/working_times/#{working_time}", working_time: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/working_times/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2024-10-14T12:16:00",
               "start_time" => "2024-10-14T12:16:00",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, working_time: working_time} do
      conn = put(conn, ~p"/api/working_times/#{working_time}", working_time: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete working_time" do
    setup [:create_working_time]

    test "deletes chosen working_time", %{conn: conn, working_time: working_time} do
      conn = delete(conn, ~p"/api/working_times/#{working_time}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/working_times/#{working_time}")
      end
    end
  end

  defp create_working_time(_) do
    working_time = working_time_fixture()
    %{working_time: working_time}
  end
end
