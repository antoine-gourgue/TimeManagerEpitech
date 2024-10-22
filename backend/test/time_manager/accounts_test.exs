defmodule TimeManager.AccountsTest do
  use TimeManager.DataCase

  alias TimeManager.Accounts

  describe "users" do
    alias TimeManager.Accounts.User

    import TimeManager.AccountsFixtures

    @invalid_attrs %{username: nil, password: nil, email: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      role = role_fixture() # On ajoute la création d'un rôle valide
      valid_attrs = %{username: "some username", password: "some password", email: "some email", role_id: role.id}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.username == "some username"
      assert Comeonin.Bcrypt.checkpw("some password", user.password_hash) # Utilise la version correcte pour vérifier le mot de passe
      assert user.email == "some email"
      assert user.role_id == role.id
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      role = role_fixture() # Crée un rôle valide pour la mise à jour
      update_attrs = %{username: "some updated username", password: "some updated password", email: "some updated email", role_id: role.id}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert Comeonin.Bcrypt.checkpw("some updated password", user.password_hash) # Utilise la version correcte pour vérifier le mot de passe
      assert user.email == "some updated email"
      assert user.role_id == role.id
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "roles" do
    alias TimeManager.Accounts.Role

    import TimeManager.AccountsFixtures

    @invalid_attrs %{name: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Role{} = role} = Accounts.create_role(valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Role{} = role} = Accounts.update_role(role, update_attrs)
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
      assert role == Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Accounts.change_role(role)
    end
  end

  describe "user_teams" do
    alias TimeManager.Accounts.UserTeam

    import TimeManager.AccountsFixtures

    @invalid_attrs %{}

    test "list_user_teams/0 returns all user_teams" do
      user_team = user_team_fixture()
      assert Accounts.list_user_teams() == [user_team]
    end

    test "get_user_team!/1 returns the user_team with given id" do
      user_team = user_team_fixture()
      assert Accounts.get_user_team!(user_team.id) == user_team
    end

    test "create_user_team/1 with valid data creates a user_team" do
      valid_attrs = %{team_id: team_fixture().id, user_id: user_fixture().id}

      assert {:ok, %UserTeam{} = user_team} = Accounts.create_user_team(valid_attrs)
    end

    test "create_user_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_team(@invalid_attrs)
    end

    test "update_user_team/2 with valid data updates the user_team" do
      user_team = user_team_fixture()
      update_attrs = %{team_id: team_fixture().id}

      assert {:ok, %UserTeam{} = user_team} = Accounts.update_user_team(user_team, update_attrs)
    end

    test "update_user_team/2 with invalid data returns error changeset" do
      user_team = user_team_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_team(user_team, @invalid_attrs)
      assert user_team == Accounts.get_user_team!(user_team.id)
    end

    test "delete_user_team/1 deletes the user_team" do
      user_team = user_team_fixture()
      assert {:ok, %UserTeam{}} = Accounts.delete_user_team(user_team)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_team!(user_team.id) end
    end

    test "change_user_team/1 returns a user_team changeset" do
      user_team = user_team_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_team(user_team)
    end
  end
end
