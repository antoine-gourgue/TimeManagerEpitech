defmodule TimeManager.Audit.AuditLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "audit_logs" do
    field :action, :string
    field :new_value, :map
    field :table_name, :string
    field :record_id, :integer
    field :old_value, :map
    field :changed_by, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(audit_log, attrs) do
    audit_log
    |> cast(attrs, [:table_name, :record_id, :action, :old_value, :new_value])
    |> validate_required([:table_name, :record_id, :action])
  end
end
