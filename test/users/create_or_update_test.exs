defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "when all parameters are valid, saves the user" do
      parameters = %{name: "Mauricio", email: "mauricio@server.com", cpf: "12345678900"}

      response = CreateOrUpdate.call(parameters)
      {_status, id} = response

      expected_response = {:ok, id}

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error" do
      parameters = %{name: "Mauricio", email: "mauricio@server.com", cpf: 0}

      response = CreateOrUpdate.call(parameters)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
