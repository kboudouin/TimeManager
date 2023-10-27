defmodule Api.Users do
  import Ecto.Query

  alias Api.Repo
  alias Api.User

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
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
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
end
