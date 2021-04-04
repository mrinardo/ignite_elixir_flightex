defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking))

    {:ok, booking.id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  def get_all, do: Agent.get(__MODULE__, & &1)

  def get_all_by_date(%Date{} = from_date, %Date{} = to_date),
    do: Agent.get(__MODULE__, &get_by_date(&1, from_date, to_date))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Flight booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp get_by_date(state, from_date, to_date) do
    Enum.filter(state, fn elem -> filter_by_date(elem, from_date, to_date) end)
  end

  defp filter_by_date({_id, booking}, from_date, to_date) do
    from_comparison = Date.compare(booking.data_completa, from_date)
    to_comparison = Date.compare(booking.data_completa, to_date)

    from_comparison != :lt and to_comparison != :gt
  end

  defp update_state(state, %Booking{id: id} = booking), do: Map.put(state, id, booking)
end
