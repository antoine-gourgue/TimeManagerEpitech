defmodule TimeManagerWeb.Plugs.AuthenticateTest do
  use TimeManagerWeb.ConnCase
  import Plug.Test

  import TimeManager.AccountsFixtures
  alias TimeManagerWeb.Plugs.Authenticate
  alias TimeManager.Accounts  # Pour accéder à Accounts et générer des users

  describe "Authenticate Plug" do
    setup do
      # Utilisation de `user_fixture` pour créer un utilisateur
      user = user_fixture(%{role_id: 1})  # Un utilisateur avec un rôle admin
      {:ok, conn: build_conn(), user: user}
    end

    test "allows access with valid token", %{conn: conn, user: user} do
      # Générer un token JWT valide pour cet utilisateur
      valid_token = Accounts.generate_jwt(user)

      # Ajouter le token à la requête dans l'en-tête Authorization
      conn = put_req_header(conn, "authorization", "Bearer #{valid_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérification que l'ID utilisateur a été assigné dans conn.assigns
      assert conn.assigns[:current_user_id] == user.id
    end

    test "denies access with invalid token", %{conn: conn} do
      # Utiliser un token invalide
      invalid_token = "invalid_token"
      conn = put_req_header(conn, "authorization", "Bearer #{invalid_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifier que la réponse est 401 Unauthorized
      assert conn.status == 401
    end

    test "denies access without token", %{conn: conn} do
      # Appeler le plug sans token
      conn = Authenticate.call(conn, %{})

      # Vérifier que la réponse est 401 Unauthorized
      assert conn.status == 401
    end

    test "denies access with expired token", %{conn: conn, user: user} do
      # Générer un token expiré (en modifiant l'expiration dans les claims)
      expired_token = Accounts.generate_jwt(user, -3600)  # Expiré il y a une heure

      conn = put_req_header(conn, "authorization", "Bearer #{expired_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifier que la réponse est 401 Unauthorized (token expiré)
      assert conn.status == 401
    end

    test "denies access with insufficient role", %{conn: conn, user: user} do
      # Modifier le rôle de l'utilisateur pour tester une autorisation de rôle insuffisante
      user = user_fixture(%{role_id: 2})  # Rôle insuffisant pour passer le test

      # Générer un token valide pour cet utilisateur
      token = Accounts.generate_jwt(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifier que la réponse est 403 Forbidden (rôle insuffisant)
      assert conn.status == 403
    end
  end
end
