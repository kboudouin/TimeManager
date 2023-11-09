defmodule Api.Users do
  import Ecto.Query

  alias Api.Repo
  alias Api.User
  alias Pbkdf2

  def list_users do
    Repo.all(User)
  end

  def filter_users(params) do
    query =
      from(u in User,
        where: ilike(u.email, ^"%#{params["email"]}%"),
        where: ilike(u.username, ^"%#{params["username"]}%")
      )

    Repo.all(query)
  end

def create_user(attrs \\ %{}) do
    changeset = User.changeset(%User{}, attrs)
    if changeset.valid? do
      Repo.insert(changeset)
    else
      {:error, changeset}
    end
  end

  def get_user!(id), do: Repo.get!(User, id)

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end


def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && Pbkdf2.verify_pass(password, user.password_hash) -> {:ok, user}
      true -> :error
    end
  end
end
