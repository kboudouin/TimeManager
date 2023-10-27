defmodule Api.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field(:status, :boolean)
    field(:time, :utc_datetime)
    field(:user, :string)
    @derive {Jason.Encoder, only: [:user, :time, :status]}
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:user,:status])
    |> validate_required([:user])
    |> put_change(:time, DateTime.truncate(DateTime.utc_now(), :second))
  end
end
