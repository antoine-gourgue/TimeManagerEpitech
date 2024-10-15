defmodule TimeManagerWeb.Plugs.Authenticate do
  import Plug.Conn
  import Joken

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        secret = Application.get_env(:time_manager, :jwt_secret)

        case verify_and_validate(token, secret) do
          {:ok, claims} ->
            assign(conn, :current_user_id, claims["sub"])

          {:error, _} ->
            conn
            |> send_resp(401, "Unauthorized")
            |> halt()
        end

      _ ->
        conn
        |> send_resp(401, "Unauthorized")
        |> halt()
    end
  end

  def verify_jwt(token) do
    secret = Application.get_env(:time_manager, :jwt_secret)
    Joken.verify_and_validate(token, secret)
  end
end
