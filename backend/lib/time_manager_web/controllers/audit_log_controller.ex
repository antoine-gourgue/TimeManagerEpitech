defmodule TimeManagerWeb.AuditLogController do
  use TimeManagerWeb, :controller

  alias TimeManager.AuditLogs
  alias TimeManager.AuditLogs.AuditLog

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    audit_logs = AuditLogs.list_audit_logs()
    render(conn, "index.json", audit_logs: audit_logs)
  end

  def show(conn, %{"id" => id}) do
    audit_log = AuditLogs.get_audit_log!(id)
    render(conn, "show.json", audit_log: audit_log)
  end

  def create(conn, %{"audit_log" => audit_log_params}) do
    case AuditLogs.create_audit_log(audit_log_params) do
      {:ok, audit_log} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.audit_log_path(conn, :show, audit_log))
        |> render("show.json", audit_log: audit_log)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TimeManagerWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    audit_log = AuditLogs.get_audit_log!(id)

    with {:ok, _audit_log} <- AuditLogs.delete_audit_log(audit_log) do
      send_resp(conn, :no_content, "")
    end
  end
end
