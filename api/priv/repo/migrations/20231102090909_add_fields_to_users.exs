defmodule Api.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
      add :team, {:array, :string}
      add :role, :string
    end
  end
end
