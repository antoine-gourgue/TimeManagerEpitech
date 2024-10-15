defmodule TimeManager.TimeEntries do
  @moduledoc """
  The context for managing working times and clocks.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Tracking.{Clock, WorkingTime}

  # Liste tous les clocks
  @doc """
  Returns the list of clocks.
  """
  def list_clocks do
    Repo.all(Clock)
  end

  # Obtient un clock spécifique
  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.
  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  # Crée un nouveau clock
  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  # Met à jour un clock
  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  # Supprime un clock
  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}
  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  # Renvoie un changeset pour le suivi des changements
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.
  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end


  @doc """
  Returns the list of clocks for a specific user.

  ## Examples

      iex> list_clocks_for_user(1)
      [%Clock{}, ...]

  """
  def list_clocks_for_user(user_id) do
    Repo.all(from c in Clock, where: c.user_id == ^user_id)
  end
end
