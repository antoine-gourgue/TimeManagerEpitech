defmodule TimeManagerWeb.WorkingTimeJSON do
  alias TimeManager.Tracking.WorkingTime

  @doc """
  Renders a list of working_times.
  """
  def index(%{working_times: working_times}) do
    %{data: for(working_time <- working_times, do: data(working_time))}
  end

  @doc """
  Renders a single working_time.
  """
  def show(%{working_time: working_time}) do
    %{data: data(working_time)}
  end

  defp data(%WorkingTime{} = working_time) do
    %{
      id: working_time.id,
      type: working_time.type,
      start_time: working_time.start_time,
      end_time: working_time.end_time
    }
  end
end
