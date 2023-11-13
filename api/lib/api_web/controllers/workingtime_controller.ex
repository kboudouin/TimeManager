defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller

  alias Api.Workingtimes
  alias Api.Workingtime
  alias Api.User

  action_fallback(ApiWeb.FallbackController)

  defp check_user_permission(%User{id: user_id, role: "admin"}, _requested_id, _action), do: :ok
  defp check_user_permission(%User{id: user_id, role: "employee"}, requested_id, _action) when user_id == requested_id, do: :ok
  defp check_user_permission(%User{id: user_id, role: "manager"}, requested_id, _action) when user_id == requested_id, do: :ok
  defp check_user_permission(_, _, _), do: {:error, "Permission denied"}

  def index(conn, %{"userID" => user_id_string, "start" => start_dt, "end" => end_dt}) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(user_id_string)

    case check_user_permission(current_user, requested_id, :index) do
      :ok ->
        workingtimes = Workingtimes.list_workingtimes_for_user(user_id_string, start_dt, end_dt)
        json(conn, %{workingtimes: workingtimes})

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def show(conn, %{"userID" => user_id_string, "id" => id}) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(user_id_string)

    case check_user_permission(current_user, requested_id, :show) do
      :ok ->
        workingtime = Workingtimes.get_workingtime_by_user_and_id(user_id_string, id)
        json(conn, workingtime)

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def create(conn, %{"userID" => user_id_string} = params) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(user_id_string)

    case check_user_permission(current_user, requested_id, :create) do
      :ok ->
        case Workingtimes.create_workingtime(Map.put(params, "user", user_id_string)) do
          {:ok, %Workingtime{} = workingtime} ->
            json(conn, %{workingtime: workingtime})

          _ ->
            json(conn, %{error: "Failed to create workingtime"})
        end

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def update(conn, %{"id" => id_string} = params) do
    try do
      id = String.to_integer(id_string)
      workingtime = Workingtimes.get_workingtime!(id)
      wt_params = Map.drop(params, ["id"])
      Workingtimes.update_workingtime!(workingtime, wt_params)
      json(conn, %{info: "Workingtime has been updated"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No workingtime has been found!"})
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      workingtime = Workingtimes.get_workingtime!(id)
      Workingtimes.delete_workingtime(workingtime)
      json(conn, %{info: "Workingtime Has Been Deleted!"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No workingtime has been found!"})
    end
  end
end
