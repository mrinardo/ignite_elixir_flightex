defmodule FlightexTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex

  setup do
    Flightex.start_agents()

    user_parameters = %{name: "Mauricio", email: "mauricio@server.com", cpf: "12345678900"}

    booking_parameters = %{
      data_completa: ~N[2021-04-02 17:13:00],
      cidade_origem: "São Paulo",
      cidade_destino: "Berlim"
    }

    {:ok, user_parameters: user_parameters, booking_parameters: booking_parameters}
  end

  describe "create_user/1" do
    test "when all parameters are valid, saves the user", %{user_parameters: user_parameters} do
      response = Flightex.create_user(user_parameters)

      assert {:ok, _uuid} = response
    end

    test "when there are invalid parameters, returns an error", %{
      user_parameters: user_parameters
    } do
      response = Flightex.create_user(%{user_parameters | cpf: 0})

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end

  describe "create_booking/2" do
    test "when all parameters are valid, saves the booking", %{
      user_parameters: user_parameters,
      booking_parameters: booking_parameters
    } do
      {:ok, id_usuario} = Flightex.create_user(user_parameters)

      response = Flightex.create_booking(id_usuario, booking_parameters)

      assert {:ok, _uuid} = response
    end

    test "when the user id is not valid, returns an error", %{
      booking_parameters: booking_parameters
    } do
      response = Flightex.create_booking("000000000000", booking_parameters)

      expected_response = {:error, "User not found with id=000000000000"}

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error", %{
      user_parameters: user_parameters,
      booking_parameters: booking_parameters
    } do
      {:ok, id_usuario} = Flightex.create_user(user_parameters)

      response = Flightex.create_booking(id_usuario, %{booking_parameters | data_completa: "0"})

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end

  describe "get_booking/1" do
    test "when the id is found, returns the booking", %{
      user_parameters: user_parameters,
      booking_parameters: booking_parameters
    } do
      {:ok, id_usuario} = Flightex.create_user(user_parameters)
      {:ok, id_booking} = Flightex.create_booking(id_usuario, booking_parameters)

      response = Flightex.get_booking(id_booking)

      expected_response = {:ok, build(:booking, id: id_booking, id_usuario: id_usuario)}

      assert response == expected_response
    end

    test "when the id is not found, returns an error" do
      response = Flightex.get_booking("000000000000")

      expected_response = {:error, "Flight booking not found"}

      assert response == expected_response
    end
  end

  describe "generate_report/3" do
    test "generates the report", %{
      user_parameters: user_parameters,
      booking_parameters: booking_parameters
    } do
      {:ok, id_usuario} = Flightex.create_user(user_parameters)
      Flightex.create_booking(id_usuario, booking_parameters)

      response = Flightex.generate_report(~D[2021-04-02], ~D[2021-04-02])

      expected_response = {:ok, "Report generated successfully"}

      assert response == expected_response
    end
  end
end
