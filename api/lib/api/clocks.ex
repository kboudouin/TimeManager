defmodule Api.Clocks do
  alias Api.Repo
  alias Api.Clock

  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  def create_or_update_clock(user_id, attrs \\ %{}) do
    IO.inspect(attrs, label: "attrs in clocks")

    case get_clock!(user_id) do
      nil ->
        create_clock(%{user: user_id} |> Map.merge(attrs))

      %Clock{} = existing_clock ->
        changeset = Clock.changeset(existing_clock, attrs)
        Repo.update(changeset)
    end
  end

  def get_clock!(nil), do: nil
  def get_clock!(user_id), do: Repo.get_by(Clock, user: user_id)
end
