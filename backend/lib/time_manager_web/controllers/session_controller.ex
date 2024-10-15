defmodule TimeManagerWeb.SessionController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts

  def login(conn, %{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email(email)

    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid email or password.")
        |> render("login.html")

      user ->
        if Accounts.check_password(user, password) do
          token = Accounts.generate_jwt(user)  # Utilisez la méthode de token

          conn
          |> put_resp_header("Authorization", "Bearer #{token}")
          |> json(%{message: "Logged in successfully", token: token})
        else
          conn
          |> put_flash(:error, "Invalid email or password.")
          |> render("login.html")
        end
    end
  end
end
