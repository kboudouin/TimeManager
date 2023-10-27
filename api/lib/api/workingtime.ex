defmodule Api.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field(:start, :utc_datetime)
    field(:user, :string)
    field(:end, :utc_datetime)
    @derive {Jason.Encoder, only: [:id, :start, :end, :user]}
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
