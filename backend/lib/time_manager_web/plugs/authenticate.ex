defmodule TimeManagerWeb.Plugs.Authenticate do
  import Plug.Conn
  import Joken

  def init(default), do: default

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        IO.inspect(token, label: "Received Token")

        case manual_verify_token(token) do
          {:ok, claims} ->
            assign(conn, :current_user_id, claims["sub"])

          {:error, reason} ->
            IO.inspect(reason, label: "Token Verification Error")
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

  defp manual_verify_token(token) do
    # Afficher le token brut
    IO.inspect(token, label: "Raw Token")

    # Divise le token en ses trois parties
    parts = String.split(token, ".")

    # Vérifie que nous avons bien 3 parties
    case parts do
      [header, payload, signature] ->
        # Décode le header et le payload
        decoded_header = decode_base64url(header)
        decoded_payload = decode_base64url(payload)

        # Vérification des erreurs de décodage
        with {:ok, header_map} <- Jason.decode(decoded_header),
             {:ok, payload_map} <- Jason.decode(decoded_payload) do

          # Vérification de l'expiration
          current_time = Joken.current_time()
          if payload_map["exp"] < current_time do
            IO.inspect("Token Expired", label: "Error")
            {:error, "Token Expired"}
          else
            # Vérifier la signature
            secret = Application.get_env(:time_manager, :jwt_secret)

            # Log de la signature avant vérification
            IO.inspect(signature, label: "Signature to Verify")

            # Vérifier la signature manuellement
            if manual_verify_signature(header, payload, signature, secret) do
              IO.inspect(payload_map, label: "Valid Token Claims")
              {:ok, payload_map}
            else
              IO.inspect("Invalid Signature", label: "Error")
              {:error, "Invalid Token"}
            end
          end
        else
          {:error, _reason} ->
            IO.inspect("Failed to decode JSON", label: "Error")
            {:error, "Invalid Token"}
        end

      _ ->
        IO.inspect("Invalid Token Format", label: "Error")
        {:error, "Invalid Token"}
    end
  end

  defp manual_verify_signature(header, payload, signature, secret) do
    # Créer la signature attendue
    expected_signature = create_signature(header, payload, secret)

    # Comparer la signature attendue avec celle extraite
    expected_signature == signature
  end

  defp create_signature(header, payload, secret) do
    header_payload = header <> "." <> payload

    # Utiliser HMAC avec :crypto.mac/4
    :crypto.mac(:hmac, :sha256, secret, header_payload)
    |> Base.encode64()
    |> String.replace("+", "-")
    |> String.replace("/", "_")
    |> String.trim_trailing("=")
  end

  defp decode_base64url(encoded) do
    # Remplace les caractères URL sécurisés et ajoute le padding si nécessaire
    padded_encoded = add_padding(encoded)
    :base64.decode(padded_encoded)
  end

  defp add_padding(encoded) do
    padding = 4 - rem(String.length(encoded), 4)
    if padding < 4 do
      encoded <> String.duplicate("=", padding)
    else
      encoded
    end
  end
end
