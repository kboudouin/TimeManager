defmodule ApiWeb.GuardianErrorHandler do
  import Plug.Conn

  def auth_error(conn, {:invalid_token, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_resp_header("content-type", "application/json")
    |> send_resp(:unauthorized, "{\"error\":\"Invalid token\"}")
  end

  def auth_error(conn, _error, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_resp_header("content-type", "application/json")
    |> send_resp(:unauthorized, "{\"error\":\"Unauthorized\"}")
  end

end
