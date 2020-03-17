defmodule UserExtraction2 do
  @doc """
    Accept a map that represents a user and has 3 expected fields. Enum.filter/2
    takes an enumerable and function, returning only the elements for which the
    function returns a truthy value. Map.has_key/2 checks for the presence of a
    key, and here we check for the lack of a key. If all keys are present, the
    result will be an empty list and we return a map using all passed values.
    Otherwise, the list will contain the key for the missing elements and we
    use that to return a meaningful error message.
  """
  def extract_user(user) do
    case Enum.filter(
          ["login", "email", "password"],
          &(not Map.has_key?(user, &1))
         ) do
      [] ->
        {:ok, %{
          login: user["login"],
          email: user["email"],
          password: user["password"]
        }}
      missing_fields ->
        {:error, "Missing fields: #{Enum.join(missing_fields, ", ")}"}
    end
  end
end
