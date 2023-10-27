defmodule Api.Workingtimes do
  alias Api.Repo
  alias Api.Workingtime

  import Ecto.Query

  def list_workingtimes do
    Repo.all(Api.Workingtime)
  end

  def get_workingtime_by_user_and_id(user_id, id) do
    query =
      from(w in Api.Workingtime,
        where: w.user == ^user_id and w.id == ^id
      )

    Api.Repo.one(query)
  end

  def list_workingtimes_for_user(user_id, start_datetime_str, end_datetime_str) do
    {:ok, start_datetime, _} = DateTime.from_iso8601(start_datetime_str)
    {:ok, end_datetime, _} = DateTime.from_iso8601(end_datetime_str)

    query =
      from(w in Api.Workingtime,
        where: w.user == ^user_id,
        where: w.start >= ^start_datetime,
        where: w.end <= ^end_datetime,
        order_by: [asc: w.start]
      )

    Api.Repo.all(query)
  end

  def get_workingtime!(id), do: Repo.get!(Api.Workingtime, id)

  def create_workingtime(attrs \\ %{}) do
    %Api.Workingtime{}
    |> Api.Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  def update_workingtime!(%Api.Workingtime{} = workingtime, attrs) do
    workingtime
    |> Api.Workingtime.changeset(attrs)
    |> Repo.update()
  end

  def delete_workingtime(%Api.Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end
end
