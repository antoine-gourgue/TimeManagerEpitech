defmodule TimeManager.Tracking.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field :type, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:type, :start_time, :end_time,:user_id])
    |> validate_required([:type, :start_time, :end_time,:user_id])
  end
end
