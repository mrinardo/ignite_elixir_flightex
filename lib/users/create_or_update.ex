defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  def call(_param) do
    {:error, "Invalid parameters"}
  end

  defp save_user({:ok, %User{} = user}) do
    case UserAgent.save(user) do
      {:ok, id} -> {:ok, id}
      error -> error
    end
  end

  defp save_user({:error, _reason} = error), do: error
end
