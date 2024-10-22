defmodule TimeManager.TrackingFixtures do
  @moduledoc """
  This module defines test helpers for creating entities
  via the `TimeManager.Tracking` context.
  """

  alias TimeManager.AccountsFixtures
  alias TimeManager.Tracking
  alias TimeManager.TimeEntries

  @doc """
  Generate a clock with valid data.
  """
  def clock_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()  # Crée un utilisateur pour associer le clock

    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: "active",
        time: ~N[2024-10-13 12:17:00],
        user_id: user.id  # Associe l'utilisateur au clock
      })
      |> Tracking.create_clock()

    clock
  end

  @doc """
  Generate a working_time with valid data.
  """
  def working_time_fixture(attrs \\ %{}) do
    user = AccountsFixtures.user_fixture()  # Crée un utilisateur pour associer le working_time

    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        type: "normal",
        start_time: ~N[2024-10-13 09:00:00],
        end_time: ~N[2024-10-13 17:00:00],
        user_id: user.id  # Associe l'utilisateur au working_time
      })
      |> Tracking.create_working_time()

    working_time
  end
end
