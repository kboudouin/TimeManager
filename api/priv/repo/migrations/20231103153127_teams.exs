defmodule Api.Repo.Migrations.Teams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :leaderId, :integer
      add :leader, :string
      add :members, { :array, :map }

      timestamps(type: :utc_datetime)
    end
  end
end
