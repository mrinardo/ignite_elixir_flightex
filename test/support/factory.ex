defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Mauricio",
      email: "mauricio@server.com",
      cpf: "12345678900"
    }
  end

  def booking_factory do
    %Booking{
      id: UUID.uuid4(),
      data_completa: ~N[2021-04-02 17:13:00],
      cidade_origem: "São Paulo",
      cidade_destino: "Berlim",
      id_usuario: UUID.uuid4()
    }
  end
end
