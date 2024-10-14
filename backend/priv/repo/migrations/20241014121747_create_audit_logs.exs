defmodule TimeManager.Repo.Migrations.CreateAuditLogs do
  use Ecto.Migration

  def change do
    create table(:audit_logs) do
      add :table_name, :string
      add :record_id, :integer
      add :action, :string
      add :old_value, :map
      add :new_value, :map
      add :changed_by, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:audit_logs, [:changed_by])
  end
end
