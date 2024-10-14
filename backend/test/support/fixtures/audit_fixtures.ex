defmodule TimeManager.AuditFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Audit` context.
  """

  @doc """
  Generate a audit_log.
  """
  def audit_log_fixture(attrs \\ %{}) do
    {:ok, audit_log} =
      attrs
      |> Enum.into(%{
        action: "some action",
        new_value: %{},
        old_value: %{},
        record_id: 42,
        table_name: "some table_name"
      })
      |> TimeManager.Audit.create_audit_log()

    audit_log
  end
end
