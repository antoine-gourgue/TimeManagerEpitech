defmodule TimeManager.AuditTest do
  use TimeManager.DataCase

  alias TimeManager.Audit

  describe "audit_logs" do
    alias TimeManager.Audit.AuditLog

    import TimeManager.AuditFixtures

    @invalid_attrs %{action: nil, new_value: nil, table_name: nil, record_id: nil, old_value: nil}

    test "list_audit_logs/0 returns all audit_logs" do
      audit_log = audit_log_fixture()
      assert Audit.list_audit_logs() == [audit_log]
    end

    test "get_audit_log!/1 returns the audit_log with given id" do
      audit_log = audit_log_fixture()
      assert Audit.get_audit_log!(audit_log.id) == audit_log
    end

    test "create_audit_log/1 with valid data creates a audit_log" do
      valid_attrs = %{action: "some action", new_value: %{}, table_name: "some table_name", record_id: 42, old_value: %{}}

      assert {:ok, %AuditLog{} = audit_log} = Audit.create_audit_log(valid_attrs)
      assert audit_log.action == "some action"
      assert audit_log.new_value == %{}
      assert audit_log.table_name == "some table_name"
      assert audit_log.record_id == 42
      assert audit_log.old_value == %{}
    end

    test "create_audit_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Audit.create_audit_log(@invalid_attrs)
    end

    test "update_audit_log/2 with valid data updates the audit_log" do
      audit_log = audit_log_fixture()
      update_attrs = %{action: "some updated action", new_value: %{}, table_name: "some updated table_name", record_id: 43, old_value: %{}}

      assert {:ok, %AuditLog{} = audit_log} = Audit.update_audit_log(audit_log, update_attrs)
      assert audit_log.action == "some updated action"
      assert audit_log.new_value == %{}
      assert audit_log.table_name == "some updated table_name"
      assert audit_log.record_id == 43
      assert audit_log.old_value == %{}
    end

    test "update_audit_log/2 with invalid data returns error changeset" do
      audit_log = audit_log_fixture()
      assert {:error, %Ecto.Changeset{}} = Audit.update_audit_log(audit_log, @invalid_attrs)
      assert audit_log == Audit.get_audit_log!(audit_log.id)
    end

    test "delete_audit_log/1 deletes the audit_log" do
      audit_log = audit_log_fixture()
      assert {:ok, %AuditLog{}} = Audit.delete_audit_log(audit_log)
      assert_raise Ecto.NoResultsError, fn -> Audit.get_audit_log!(audit_log.id) end
    end

    test "change_audit_log/1 returns a audit_log changeset" do
      audit_log = audit_log_fixture()
      assert %Ecto.Changeset{} = Audit.change_audit_log(audit_log)
    end
  end
end
