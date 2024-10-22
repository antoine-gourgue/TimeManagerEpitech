defmodule TimeManager.Accounts do
    @moduledoc """
    The Accounts context.
    """

    import Ecto.Query, warn: false
    alias TimeManager.Repo

    alias TimeManager.Accounts.User

    import Joken
    @jwt_secrete "7c39900646686a9ca177b98e8bc77516dcb867e073b5a52730d80d21e983d6d7"


    @doc """
    Returns the list of users.

    ## Examples

        iex> list_users()
        [%User{}, ...]

    """
    def list_users do
      Repo.all(User)
    end

    @doc """
    Gets a single user.

    Raises `Ecto.NoResultsError` if the User does not exist.

    ## Examples

        iex> get_user!(123)
        %User{}

        iex> get_user!(456)
        ** (Ecto.NoResultsError)

    """
    def get_user!(id), do: Repo.get!(User, id)

    @doc """
    Creates a user.

    ## Examples

        iex> create_user(%{field: value})
        {:ok, %User{}}

        iex> create_user(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_user(attrs \\ %{}) do
      %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
    end

    @doc """
    Updates a user.

    ## Examples

        iex> update_user(user, %{field: new_value})
        {:ok, %User{}}

        iex> update_user(user, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_user(%User{} = user, attrs) do
      user
      |> User.changeset(attrs)
      |> Repo.update()
    end

    @doc """
    Deletes a user.

    ## Examples

        iex> delete_user(user)
        {:ok, %User{}}

        iex> delete_user(user)
        {:error, %Ecto.Changeset{}}

    """
    def delete_user(%User{} = user) do
      Repo.delete(user)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking user changes.

    ## Examples

        iex> change_user(user)
        %Ecto.Changeset{data: %User{}}

    """
    def change_user(%User{} = user, attrs \\ %{}) do
      User.changeset(user, attrs)
    end

    alias TimeManager.Accounts.Role

    @doc """
    Returns the list of roles.

    ## Examples

        iex> list_roles()
        [%Role{}, ...]

    """
    def list_roles do
      Repo.all(Role)
    end

    @doc """
    Gets a single role.

    Raises `Ecto.NoResultsError` if the Role does not exist.

    ## Examples

        iex> get_role!(123)
        %Role{}

        iex> get_role!(456)
        ** (Ecto.NoResultsError)

    """
    def get_role!(id), do: Repo.get!(Role, id)

    @doc """
    Creates a role.

    ## Examples

        iex> create_role(%{field: value})
        {:ok, %Role{}}

        iex> create_role(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_role(attrs \\ %{}) do
      %Role{}
      |> Role.changeset(attrs)
      |> Repo.insert()
    end

    @doc """
    Updates a role.

    ## Examples

        iex> update_role(role, %{field: new_value})
        {:ok, %Role{}}

        iex> update_role(role, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_role(%Role{} = role, attrs) do
      role
      |> Role.changeset(attrs)
      |> Repo.update()
    end

    @doc """
    Deletes a role.

    ## Examples

        iex> delete_role(role)
        {:ok, %Role{}}

        iex> delete_role(role)
        {:error, %Ecto.Changeset{}}

    """
    def delete_role(%Role{} = role) do
      Repo.delete(role)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking role changes.

    ## Examples

        iex> change_role(role)
        %Ecto.Changeset{data: %Role{}}

    """
    def change_role(%Role{} = role, attrs \\ %{}) do
      Role.changeset(role, attrs)
    end

    alias TimeManager.Accounts.Team

    @doc """
    Returns the list of teams.

    ## Examples

        iex> list_teams()
        [%Team{}, ...]

    """
    def list_teams do
      Repo.all(Team)
    end

    @doc """
    Gets a single team.

    Raises `Ecto.NoResultsError` if the Team does not exist.

    ## Examples

        iex> get_team!(123)
        %Team{}

        iex> get_team!(456)
        ** (Ecto.NoResultsError)

    """
    def get_team!(id), do: Repo.get!(Team, id)

    @doc """
    Creates a team.

    ## Examples

        iex> create_team(%{field: value})
        {:ok, %Team{}}

        iex> create_team(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_team(attrs \\ %{}) do
      %Team{}
      |> Team.changeset(attrs)
      |> Repo.insert()
      IO.inspect(result, label: "Result from Repo.insert in create_team")
    end

    @doc """
    Updates a team.

    ## Examples

        iex> update_team(team, %{field: new_value})
        {:ok, %Team{}}

        iex> update_team(team, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_team(%Team{} = team, attrs) do
      team
      |> Team.changeset(attrs)
      |> Repo.update()
    end

    @doc """
    Deletes a team.

    ## Examples

        iex> delete_team(team)
        {:ok, %Team{}}

        iex> delete_team(team)
        {:error, %Ecto.Changeset{}}

    """
    def delete_team(%Team{} = team) do
      Repo.delete(team)
    end

    @doc """
    Returns an `%Ecto.Changeset{}` for tracking team changes.

    ## Examples

        iex> change_team(team)
        %Ecto.Changeset{data: %Team{}}

    """
    def change_team(%Team{} = team, attrs \\ %{}) do
      Team.changeset(team, attrs)
    end

    alias TimeManager.Accounts.UserTeam

    @doc """
    Returns the list of user_teams.
    """
    def list_user_teams do
      Repo.all(UserTeam)
    end

    @doc """
    Gets a single user_team.
    Raises `Ecto.NoResultsError` if the User team does not exist.
    """
    def get_user_team!(id), do: Repo.get!(UserTeam, id)

    @doc """
    Creates a user_team.
    """
    def create_user_team(attrs \\ %{}) do
      %UserTeam{}
      |> UserTeam.changeset(attrs)
      |> Repo.insert()
    end

    @doc """
    Updates a user_team.
    """
    def update_user_team(%UserTeam{} = user_team, attrs) do
      user_team
      |> UserTeam.changeset(attrs)
      |> Repo.update()
    end

    @doc """
    Deletes a user_team.
    """
    def delete_user_team(%UserTeam{} = user_team) do
      Repo.delete(user_team)
    end

    # Vérifie si le mot de passe est correct
    def check_password(%User{password: hashed_password}, password) do
      Bcrypt.verify_pass(password, hashed_password)  # Vérifiez le mot de passe
    end

    def get_user_by_email(email) do
      Repo.get_by(User, email: email)
    end

    @expiration_time 30 * 24 * 60 * 60  # 30
    def generate_jwt(user) do
      # Générer un c-xsrf token aléatoire
      xstf_token = :crypto.strong_rand_bytes(16) |> Base.encode64() |> String.trim_trailing("=")

      # Étape 1 : Créer les claims
      claims = %{
        "sub" => user.id,
        "role_id" => user.role_id,
        "exp" => Joken.current_time() + @expiration_time,
        "xstf" => xstf_token
      }

      IO.inspect(claims, label: "Claims to be signed")  # Log des claims

      # Étape 2 : Signer le token avec les claims
      sign_token(claims)
    end

    defp sign_token(claims) do
      # Créer un signataire avec la clé secrète
      secret = Application.get_env(:time_manager, :jwt_secret)

      # Log de la clé secrète (assurez-vous de ne pas exposer cela en production)
      IO.inspect(secret, label: "Secret Used for Signing")

      signer = Joken.Signer.create("HS256", secret)

      # Signer le token avec les claims
      case Joken.encode_and_sign(claims, signer) do
        {:ok, token, _claims} ->
          IO.inspect(token, label: "Generated Token")  # Afficher le token généré
          token
        {:error, reason} ->
          IO.inspect(reason, label: "JWT Generation Error")
          {:error, "Could not generate token"}
      end
    end
end