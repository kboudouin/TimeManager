defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Clocks
  alias Api.Clock

  action_fallback(ApiWeb.FallbackController)

  def show(conn, %{"id" => user_id}) do
    clock = Clocks.get_clock!(user_id)
    json(conn, %{clock: clock})
  end

  def create(conn, %{"userID" => user_id}) do
    status = Map.get(conn.params, "status")
    IO.inspect(status, label: "Status in Controller")
    IO.inspect(user_id, label: "user_id in Controller")

    case Clocks.create_or_update_clock(user_id, %{status: status}) do
      {:ok, %Clock{} = clock} ->
        json(conn, %{clock: clock})

      _ ->
        json(conn, %{error: "Failed to create or update clock"})
    end
  end
end
