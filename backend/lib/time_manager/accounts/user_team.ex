defmodule TimeManager.Accounts.UserTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_teams" do
    belongs_to :user, TimeManager.Accounts.User
    belongs_to :team, TimeManager.Accounts.Team

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_team, attrs) do
    user_team
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:team_id)
  end
end
