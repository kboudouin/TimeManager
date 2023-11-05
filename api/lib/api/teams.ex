defmodule Api.Teams do
  alias Api.Repo
  alias Api.Team

  def list_teams do
    Repo.all(Team)
  end

  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def get_team!(id) do
    Repo.get!(Team, id)
  end

  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end
end
