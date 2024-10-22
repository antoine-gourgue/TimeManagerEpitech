defmodule TimeManagerWeb.Plugs.AuthenticateTest do
  use TimeManagerWeb.ConnCase
  import Plug.Test

  alias TimeManagerWeb.Plugs.Authenticate
  alias TimeManagerWeb.Auth
  alias TimeManager.Accounts

  describe "Authenticate Plug" do
    setup do
      # Créer un utilisateur dans la base de données pour les tests
      user = user_fixture() # Assure-toi d'avoir une fixture ou factory pour créer un utilisateur
      {:ok, conn: build_conn(), user: user}
    end

    test "allows access with valid token", %{conn: conn, user: user} do
      # Générer un token JWT valide pour l'utilisateur
      valid_token = Auth.generate_jwt(user)

      # Ajouter le token dans l'en-tête Authorization
      conn = put_req_header(conn, "authorization", "Bearer #{valid_token}")

      # Appeler le plug d'authentification
      conn = Authenticate.call(conn, %{})

      # Vérifiez que l'utilisateur est bien assigné
      assert conn.assigns[:current_user_id] == user.id
    end

    test "denies access with invalid token", %{conn: conn} do
      # Utiliser un token JWT invalide
      invalid_token = "invalid_token"
      conn = put_req_header(conn, "authorization", "Bearer #{invalid_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifiez que la réponse est 401 Unauthorized
      assert conn.status == 401
    end

    test "denies access without token", %{conn: conn} do
      # Appeler le plug sans ajouter de token dans l'en-tête
      conn = Authenticate.call(conn, %{})

      # Vérifiez que la réponse est 401 Unauthorized
      assert conn.status == 401
    end
  end
end
