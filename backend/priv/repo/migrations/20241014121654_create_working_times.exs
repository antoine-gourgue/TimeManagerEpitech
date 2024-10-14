defmodule TimeManager.Repo.Migrations.CreateWorkingTimes do
  use Ecto.Migration

  def change do
    create table(:working_times) do
      add :type, :string
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:working_times, [:user_id])
  end
end
