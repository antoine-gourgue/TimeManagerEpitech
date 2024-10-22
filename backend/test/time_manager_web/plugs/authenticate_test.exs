defmodule TimeManagerWeb.Plugs.AuthenticateTest do
  use TimeManagerWeb.ConnCase
  import Plug.Test

  alias TimeManagerWeb.Plugs.Authenticate

  describe "Authenticate Plug" do
    setup do
      {:ok, conn: build_conn()}
    end

    test "allows access with valid token", %{conn: conn} do
      # Simuler un token JWT valide ici
      valid_token = "your_valid_jwt_token"
      conn = put_req_header(conn, "authorization", "Bearer #{valid_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifiez que l'utilisateur est bien assigné
      assert conn.assigns[:current_user_id] != nil
    end

    test "denies access with invalid token", %{conn: conn} do
      invalid_token = "invalid_token"
      conn = put_req_header(conn, "authorization", "Bearer #{invalid_token}")

      # Appeler le plug
      conn = Authenticate.call(conn, %{})

      # Vérifiez que la réponse est 401 Unauthorized
      assert conn.status == 401
    end

    test "denies access without token", %{conn: conn} do
      # Appeler le plug sans token
      conn = Authenticate.call(conn, %{})

      # Vérifiez que la réponse est 401 Unauthorized
      assert conn.status == 401
    end
  end
end
