defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt  # Importez Bcrypt

  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string
    field :role_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role_id])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> hash_password()
    |> validate_role_id()
  end

  # Hachage du mot de passe avant l'insertion dans la base de données
  defp hash_password(changeset) do
    case get_field(changeset, :password) do
      nil -> changeset
      password ->
        # Hache le mot de passe et le stocke dans le champ 'password'
        hashed_password = Bcrypt.hash_pwd_salt(password)
        put_change(changeset, :password, hashed_password)
    end
  end

  # Vérifiez le mot de passe lors de la connexion
  def check_password(user, password) do
    # Utilise Bcrypt pour comparer le mot de passe fourni avec le hachage stocké
    Bcrypt.check_pass(user, password)
  end

  defp validate_role_id(changeset) do
    role_id = get_field(changeset, :role_id)
    if is_nil(role_id) or !is_role_exist(role_id) do
      add_error(changeset, :role_id, "is invalid")
    else
      changeset
    end
  end

  defp is_role_exist(role_id) do
    TimeManager.Repo.get(TimeManager.Accounts.Role, role_id) != nil
  end
end
