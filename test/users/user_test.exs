defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.User

  describe "build/3" do
    test "when all parameters are valid, returns the user" do
      response = User.build("Mauricio", "mauricio@server.com", "12345678900")
      {:ok, user} = response

      expected_response = {:ok, build(:user, id: user.id)}

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error" do
      response = User.build("Mauricio", "mauricio@server.com", 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
