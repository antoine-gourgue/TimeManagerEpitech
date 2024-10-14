defmodule TimeManagerWeb.AuditLogJSON do
  alias TimeManager.Audit.AuditLog

  @doc """
  Renders a list of audit_logs.
  """
  def index(%{audit_logs: audit_logs}) do
    %{data: for(audit_log <- audit_logs, do: data(audit_log))}
  end

  @doc """
  Renders a single audit_log.
  """
  def show(%{audit_log: audit_log}) do
    %{data: data(audit_log)}
  end

  defp data(%AuditLog{} = audit_log) do
    %{
      id: audit_log.id,
      table_name: audit_log.table_name,
      record_id: audit_log.record_id,
      action: audit_log.action,
      old_value: audit_log.old_value,
      new_value: audit_log.new_value
    }
  end
end
