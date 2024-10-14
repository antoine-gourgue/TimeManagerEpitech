defmodule TimeManager.TrackingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Tracking` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end_time: ~N[2024-10-13 12:16:00],
        start_time: ~N[2024-10-13 12:16:00],
        type: "some type"
      })
      |> TimeManager.Tracking.create_working_time()

    working_time
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: "some status",
        time: ~N[2024-10-13 12:17:00]
      })
      |> TimeManager.Tracking.create_clock()

    clock
  end
end
