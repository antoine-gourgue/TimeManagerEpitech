defmodule TimeManagerWeb.Plugs.AuthenticateTest do
  use TimeManagerWeb.ConnCase
  import Plug.Test
  import TimeManager.AccountsFixtures

  alias TimeManager.Accounts
  alias TimeManagerWeb.Plugs.Authenticate
  alias TimeManagerWeb.Auth

  describe "Authenticate Plug" do
    setup do
      # Utiliser la fixture importée pour créer un utilisateur
      user = user_fixture()
      {:ok, conn: build_conn(), user: user}
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
