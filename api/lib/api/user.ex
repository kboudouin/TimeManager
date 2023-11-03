defmodule Api.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pbkdf2

  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:password_hash, :string)
    field(:role, :string)
    field(:team, {:array, :string})
    @derive {Jason.Encoder, only: [:id, :username, :email, :role, :team, :inserted_at, :updated_at]}
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(username email role)a
  @optional_fields ~w()a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> put_pass_hash(attrs["password"])
  end

  defp put_pass_hash(changeset, password) when is_binary(password) do
      hash = Pbkdf2.hash_pwd_salt(password)
      put_change(changeset, :password_hash, hash)
    end


end
