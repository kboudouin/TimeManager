defmodule Api.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:leaderId, :integer)
    field(:leader, :string)
    field(:members, {:array, :map})

    @derive {Jason.Encoder, only: [:id, :leaderId, :leader, :members, :inserted_at, :updated_at]}
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(leaderId leader members)a
  @optional_fields ~w()a

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
