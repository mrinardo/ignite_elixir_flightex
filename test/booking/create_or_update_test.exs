defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/2" do
    setup do
      user = build(:user)
      id_usuario = user.id

      Flightex.start_agents()
      UserAgent.save(user)

      parameters = %{
        data_completa: ~N[2021-04-02 17:13:00],
        cidade_origem: "São Paulo",
        cidade_destino: "Nova Iorque"
      }

      {:ok, id_usuario: id_usuario, parameters: parameters}
    end

    test "when all parameters are valid, saves the booking", %{
      id_usuario: id_usuario,
      parameters: parameters
    } do
      response = CreateOrUpdate.call(id_usuario, parameters)

      assert {:ok, _uuid} = response
    end

    test "when the user id is not valid, returns an error", %{parameters: parameters} do
      response = CreateOrUpdate.call("000000000000", parameters)

      expected_response = {:error, "User not found with id=000000000000"}

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error", %{
      id_usuario: id_usuario,
      parameters: parameters
    } do
      parameters = %{parameters | data_completa: "0"}

      response = CreateOrUpdate.call(id_usuario, parameters)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
