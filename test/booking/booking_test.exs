defmodule Flightex.Users.BookingTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "when all parameters are valid, returns new booking" do
      id_usuario = UUID.uuid4()
      data_completa = ~N[2021-04-02 17:13:00]

      response = Booking.build(id_usuario, data_completa, "São Paulo", "Berlim")
      {:ok, booking} = response

      expected_response = {:ok, build(:booking, id: booking.id, id_usuario: id_usuario)}

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error" do
      id_usuario = UUID.uuid4()
      data_completa = 0

      response = Booking.build(id_usuario, data_completa, "São Paulo", "Berlim")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
