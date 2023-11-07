defmodule ApiWeb.Plugs.VerifyCsrf do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    with jwt <- Plug.Conn.Cookies.get(conn, "token"),
         {:ok, claims} <- Api.Guardian.decode_and_verify(jwt),
         {:ok, xsrf} <- get_req_header(conn, "x-csrf-token"),
         true <- secure_compare(xsrf, Guardian.Plug.xsrf_token(claims["jti"])) do
      assign(conn, :current_user, claims["sub"])
    else
      _ -> send_resp(conn, 403, "Forbidden")
    end
  end

  defp secure_compare(a, b), do: :crypto.secure_compare(a, b)
end
