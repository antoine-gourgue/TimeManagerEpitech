defmodule TimeManager.Tracking.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :string
    field :time, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:status, :time])
    |> validate_required([:status, :time])
  end
end
