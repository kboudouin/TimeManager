defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Users
  alias Api.User

  action_fallback(ApiWeb.FallbackController)

  defp check_user_permission(%User{id: user_id, role: "admin"}, _requested_id, _action), do: :ok
  defp check_user_permission(%User{id: user_id, role: "manager"}, _requested_id, _action), do: :ok
  defp check_user_permission(%User{id: user_id, role: "employee"}, requested_id, :update) when user_id == requested_id, do: :ok
  defp check_user_permission(%User{id: user_id, role: "employee"}, requested_id, :delete) when user_id == requested_id, do: :ok
  defp check_user_permission(_, _, _), do: {:error, "Permission denied"}


  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    case current_user.role do
      "admin" ->
        users = Users.list_users()
        json(conn, %{users: users})
      _ -> json(conn, %{error: "Permission denied"})
    end
  end

  def create(conn, user_params) do
    case Users.create_user(user_params) do
      {:ok, %User{} = user} ->
        user = Map.delete(user, :password_hash)
        json(conn, %{user: user})

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        conn
        |> json(%{errors: errors})

      {:error, message} ->
        conn
        |> json(%{error: message})
    end
  end


  def show(conn, %{"id" => id}) do
      current_user = Guardian.Plug.current_resource(conn)
      requested_id = String.to_integer(id)

      case check_user_permission(current_user, requested_id, :show) do
        :ok ->
          try do
            user = Users.get_user!(id)
            json(conn, %{user: user})
          rescue
            Ecto.NoResultsError ->
              json(conn, %{error: "No user has been found!"})
          end

        {:error, message} ->
          json(conn, %{error: message})
      end
  end

  def update(conn, %{"id" => id_string} = params) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(id_string)

    case check_user_permission(current_user, requested_id, :update) do
      :ok ->
        try do
          user = Users.get_user!(requested_id)
          user_params = Map.drop(params, ["id"])
          _updated_user = Users.update_user(user, user_params)
          json(conn, %{info: "User has been updated"})
        rescue
          Ecto.NoResultsError ->
            json(conn, %{error: "No user has been found!"})
        end

      {:error, message} ->
        json(conn, %{error: message})
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = Guardian.Plug.current_resource(conn)
    requested_id = String.to_integer(id)

    case check_user_permission(current_user, requested_id, :delete) do
      :ok ->
        try do
          user = Users.get_user!(requested_id)
          Users.delete_user(user)
          json(conn, %{info: "User Has Been Deleted!"})
        rescue
          Ecto.NoResultsError ->
            json(conn, %{error: "No user has been found!"})
        end

      {:error, message} ->
        json(conn, %{error: message})
    end
  end


def login(conn, %{"email" => email, "password" => password}) do
  case Api.Users.authenticate_user(email, password) do
    {:ok, user} ->
      claims = %{ "user_id" => user.id, "role" => user.role }
      {:ok, jwt, _full_claims} = Api.Guardian.encode_and_sign(user, claims)
      conn
      |> put_resp_cookie("token", jwt, http_only: false, max_age: 8 * 60 * 60)
      |> json(%{user: user,token: jwt})
    :error -> json(conn, %{error: "Invalid credentials"})
  end
end
end
