defmodule ApiWeb.TeamController do
  use ApiWeb, :controller

  alias Api.Teams

  action_fallback(ApiWeb.FallbackController)

  def index(conn, _params) do
    teams = Teams.list_teams()
    json(conn, %{teams: teams})
  end

  def create(conn, team_params) do
    with {:ok, team} <- Teams.create_team(team_params) do
      conn |> json(team)
    else
      _ -> json(conn, %{error: "Failed to create team"})
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      team = Teams.get_team!(id)
      json(conn, %{team: team})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No team has been found!"})
    end
  end

  def update(conn, %{"id" => id_string} = params) do
    try do
      id = String.to_integer(id_string)
      team = Teams.get_team!(id)
      team_params = Map.drop(params, ["id"])
      _updated_team = Teams.update_team(team, team_params)
      json(conn, %{info: "Team has been updated"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No team has been found!"})
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      team = Teams.get_team!(id)
      Teams.delete_team(team)
      json(conn, %{info: "Team Has Been Deleted!"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No team has been found!"})
    end
  end
end
