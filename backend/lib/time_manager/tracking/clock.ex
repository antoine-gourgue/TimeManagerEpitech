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
    |> cast(attrs, [:status, :time, :user_id])
    |> validate_required([:status, :time, :user_id])
  end

  def clock_in(user_id) do
    # Logique pour clock in
  end

  def clock_out(user_id) do
    # Logique pour clock out
  end
end
