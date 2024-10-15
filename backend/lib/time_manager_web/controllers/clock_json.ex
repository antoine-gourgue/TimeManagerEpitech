defmodule TimeManagerWeb.ClockJSON do
  alias TimeManager.Tracking.Clock

  @doc """
  Renders a list of clocks.
  """
  def index(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: data(clock))}
  end

  @doc """
  Renders a single clock.
  """
  def show(%{clock: clock}) do
    %{data: data(clock)}
  end

  defp data(%Clock{} = clock) do
    %{
      id: clock.id,
      status: clock.status,
      time: clock.time,
      user_id: clock.user_id,
      inserted_at: clock.inserted_at,
      updated_at: clock.updated_at
    }
  end
end
