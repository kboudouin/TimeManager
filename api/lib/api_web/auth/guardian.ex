defmodule ApiWeb.Auth.Guardian do
  use Guardian, otp_app: :api
  # alias Api.Users

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def ressource_from_claims(%{"sub" => id}) do
    case Integer.parse(id) do
      {int, _} -> {:ok, Users.get_user!(int)}
      _ -> {:error, :invalid_id}
      ressource -> {:ok, ressource}
    end
  end

  def ressource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def set_token_cookie(conn, token) do
    conn
    |> Plug.Conn.put_resp_cookie(
      "your_cookie_name",
      token,
      httponly: true,
      secure: Mix.env() == :prod, # Utilisez true en production si vous avez HTTPS
      max_age: 30 * 24 * 3600, # Durée de vie du cookie en secondes (par exemple, 30 jours)
      path: "/",
      same_site: :lax
    )
  end

  def create_token(conn, user) do
    {:ok, token, _claims} = encode_and_sign(user)
    set_token_cookie(conn, token)
    {:ok,user, token}
  end
end
