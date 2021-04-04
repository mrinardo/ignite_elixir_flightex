defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(id_usuario, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do
    with {:ok, _user} <- UserAgent.get(id_usuario),
         {:ok, booking} <- Booking.build(id_usuario, data_completa, cidade_origem, cidade_destino) do
      save_booking(booking)
    else
      error -> error
    end
  end

  defp save_booking(booking) do
    BookingAgent.save(booking)
  end
end
