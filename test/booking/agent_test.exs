defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  describe "save/1" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "saves a new booking" do
      booking = build(:booking)

      response = BookingAgent.save(booking)

      expected_response = {:ok, booking.id}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "when the provided id is found, returns the booking" do
      booking = build(:booking)
      BookingAgent.save(booking)

      response = BookingAgent.get(booking.id)

      expected_response =
        {:ok,
         %Booking{
           cidade_destino: "Berlim",
           cidade_origem: "São Paulo",
           data_completa: ~N[2021-04-02 17:13:00],
           id: booking.id,
           id_usuario: booking.id_usuario
         }}

      assert response == expected_response
    end

    test "when the provided id is not found, returns an error" do
      response = BookingAgent.get("00000000-0000-0000-0000-000000000000")

      expected_response = {:error, "Flight booking not found"}

      assert response == expected_response
    end
  end

  describe "get_all/0" do
    setup do
      BookingAgent.start_link()

      :ok
    end

    test "returns all bookings" do
      booking = build(:booking)
      BookingAgent.save(booking)

      response = BookingAgent.get_all()

      expected_response = %{
        booking.id => %Booking{
          cidade_destino: "Berlim",
          cidade_origem: "São Paulo",
          data_completa: ~N[2021-04-02 17:13:00],
          id: booking.id,
          id_usuario: booking.id_usuario
        }
      }

      assert response == expected_response
    end
  end
end
