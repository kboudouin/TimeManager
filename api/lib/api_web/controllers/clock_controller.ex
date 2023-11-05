defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Clocks
  alias Api.Clock
  alias Api.User

  action_fallback(ApiWeb.FallbackController)

  defp check_user_permission(%User{id: user_id, role: "admin"}, _requested_id, _action), do: :ok
  defp check_user_permission(%User{id: user_id, role: "employee"}, requested_id, _action) when user_id == requested_id, do: :ok
  defp check_user_permission(_, _, _), do: {:error, "Permission denied"}

  def show(conn, %{"id" => user_id_string}) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(user_id_string)

    case check_user_permission(current_user, requested_id, :show) do
      :ok ->
        clock = Clocks.get_clock!(user_id_string)
        json(conn, %{clock: clock})

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    case check_user_permission(current_user, nil, :index) do
      :ok ->
        clocks = Clocks.get_all_clocks()
        json(conn, %{clocks: clocks})

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def create(conn, %{"userID" => user_id_string}) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(user_id_string)
    status = Map.get(conn.params, "status")

    case check_user_permission(current_user, requested_id, :create) do
      :ok ->
        case Clocks.create_or_update_clock(user_id_string, %{status: status}) do
          {:ok, %Clock{} = clock} ->
            json(conn, %{clock: clock})

          _ ->
            json(conn, %{error: "Failed to create or update clock"})
        end

      {:error, message} ->
        json(conn, %{error: message})
    end
  end
end
