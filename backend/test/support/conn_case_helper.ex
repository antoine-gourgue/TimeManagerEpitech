defmodule TimeManagerWeb.ConnCaseHelper do
  import Plug.Conn  # Importation du module nécessaire
  alias TimeManager.Accounts

  def authenticate_conn(conn) do
    # Création d'un utilisateur de test
    {:ok, user} = Accounts.create_user(%{
      username: "test_user",
      email: "test@example.com",
      password: "password"
    })

    # Génération du token JWT
    {:ok, token, _claims} = Accounts.generate_jwt(user)

    # Ajout de l'en-tête Authorization avec le token JWT
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
