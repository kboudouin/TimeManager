defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Users
  alias Api.User

  action_fallback(ApiWeb.FallbackController)

  def index(conn, params) do
    users =
      case {params["username"], params["email"]} do
        {nil, nil} -> Users.list_users()
        _ -> Users.filter_users(params)
      end

    json(conn, %{users: users})
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> json(%{user: user})
    else
      _ -> json(conn, %{error: "Failed to create user"})
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      user = Users.get_user!(id)
      json(conn, %{user: user})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No user has been found!"})
    end
  end

  def update(conn, %{"id" => id_string} = params) do
    try do
      id = String.to_integer(id_string)
      user = Users.get_user!(id)
      user_params = Map.drop(params, ["id"])
      _updated_user = Users.update_user(user, user_params)
      json(conn, %{info: "User has been updated"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No user has been found!"})
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      user = Users.get_user!(id)
      Users.delete_user(user)
      json(conn, %{info: "User Has Been Deleted!"})
    rescue
      Ecto.NoResultsError ->
        json(conn, %{error: "No user has been found!"})
    end
  end
end
