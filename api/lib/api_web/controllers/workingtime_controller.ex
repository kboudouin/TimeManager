defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller

  alias Api.Workingtimes
  alias Api.Workingtime

  action_fallback(ApiWeb.FallbackController)

  def index(conn, %{"userID" => user_id, "start" => start_dt, "end" => end_dt}) do
    workingtimes = Workingtimes.list_workingtimes_for_user(user_id, start_dt, end_dt)
    json(conn, %{workingtimes: workingtimes})
  end

  def show(conn, %{"userID" => user_id, "id" => id}) do
    workingtime = Workingtimes.get_workingtime_by_user_and_id(user_id, id)
    json(conn, workingtime)
  end

  def create(conn, %{"userID" => user_id} = params) do
    case Workingtimes.create_workingtime(Map.put(params, "user", user_id)) do
      {:ok, %Workingtime{} = workingtime} ->
        json(conn, %{workingtime: workingtime})

      _ ->
        json(conn, %{error: "Failed to create workingtime"})
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
