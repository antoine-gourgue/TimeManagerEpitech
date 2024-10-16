defmodule TimeManagerWeb.SessionController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts

  def login(conn, %{"email" => email, "password" => password}) do
    IO.inspect(%{email: email, password: password}, label: "Login Attempt")

    case Accounts.get_user_by_email(email) do
      nil ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> json(%{message: "Invalid email or password."})  # Renvoie une réponse JSON

      user ->
        if Accounts.check_password(user, password) do
          token = Accounts.generate_jwt(user)
          IO.inspect(token, label: "Generated JWT Token")
          conn
          |> put_resp_header("authorization", "Bearer #{token}")
          |> json(%{message: "Logged in successfully", token: token})  # Réponse JSON sur succès
        else
          conn
          |> put_flash(:error, "Invalid credentials")
          |> json(%{message: "Invalid email or password."})  # Renvoie une réponse JSON
        end
    end
  end
end
