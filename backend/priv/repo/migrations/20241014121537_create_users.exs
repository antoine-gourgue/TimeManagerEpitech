defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:users, [:role_id])
  end
end
