defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{cpf: cpf} = user) do
    existing_userid = Agent.get(__MODULE__, &get_userid_by_cpf(&1, cpf))
    user = set_user_id(user, existing_userid)

    Agent.update(__MODULE__, &update_state(&1, user))

    {:ok, user.id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_user(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not found with id=#{id}"}
      user -> {:ok, user}
    end
  end

  defp set_user_id(user, nil), do: user
  defp set_user_id(user, id), do: %{user | id: id}

  defp get_userid_by_cpf(state, cpf) do
    result = Enum.find(state, fn {_id, elem} -> elem.cpf == cpf end)

    case result do
      nil -> nil
      {id, _} -> id
    end
  end

  defp update_state(state, %User{id: id} = user) do
    Map.put(state, id, user)
  end
end
