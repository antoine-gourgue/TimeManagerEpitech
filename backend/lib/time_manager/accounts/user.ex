defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Bcrypt  # Importez Bcrypt

  schema "users" do
    field :username, :string
    field :password, :string  # Stockage du mot de passe haché
    field :email, :string
    field :role_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)  # Assurez-vous que l'email est unique
    |> hash_password()  # Hachage du mot de passe
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
end
