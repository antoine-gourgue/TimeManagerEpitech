defmodule TimeManagerWeb.AuditLogControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.AuditFixtures

  alias TimeManager.Audit.AuditLog

  @create_attrs %{
    action: "some action",
    new_value: %{},
    table_name: "some table_name",
    record_id: 42,
    old_value: %{}
  }
  @update_attrs %{
    action: "some updated action",
    new_value: %{},
    table_name: "some updated table_name",
    record_id: 43,
    old_value: %{}
  }
  @invalid_attrs %{action: nil, new_value: nil, table_name: nil, record_id: nil, old_value: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all audit_logs", %{conn: conn} do
      conn = get(conn, ~p"/api/audit_logs")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create audit_log" do
    test "renders audit_log when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/audit_logs", audit_log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/audit_logs/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some action",
               "new_value" => %{},
               "old_value" => %{},
               "record_id" => 42,
               "table_name" => "some table_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/audit_logs", audit_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update audit_log" do
    setup [:create_audit_log]

    test "renders audit_log when data is valid", %{conn: conn, audit_log: %AuditLog{id: id} = audit_log} do
      conn = put(conn, ~p"/api/audit_logs/#{audit_log}", audit_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/audit_logs/#{id}")

      assert %{
               "id" => ^id,
               "action" => "some updated action",
               "new_value" => %{},
               "old_value" => %{},
               "record_id" => 43,
               "table_name" => "some updated table_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, audit_log: audit_log} do
      conn = put(conn, ~p"/api/audit_logs/#{audit_log}", audit_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete audit_log" do
    setup [:create_audit_log]

    test "deletes chosen audit_log", %{conn: conn, audit_log: audit_log} do
      conn = delete(conn, ~p"/api/audit_logs/#{audit_log}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/audit_logs/#{audit_log}")
      end
    end
  end

  defp create_audit_log(_) do
    audit_log = audit_log_fixture()
    %{audit_log: audit_log}
  end
end
