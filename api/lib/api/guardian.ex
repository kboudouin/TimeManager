# lib/api/guardian.ex
defmodule Api.Guardian do
  use Guardian, otp_app: :api

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    {:ok, Api.Users.get_user!(id)}
  end
  def resource_from_claims(_), do: {:error, :reason_for_error}
end
