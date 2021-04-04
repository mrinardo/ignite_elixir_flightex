defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  describe "save/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "saves an new user" do
      user = build(:user)

      response = UserAgent.save(user)

      expected_response = {:ok, user.id}

      assert response == expected_response
    end

    test "updates an existing user" do
      :user
      |> build()
      |> UserAgent.save()

      user = build(:user, name: "Mauricio XYZ")
      response = UserAgent.save(user)

      {_status, id} = response

      expected_response = {:ok, id}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "when the user is found, return the user" do
      user = build(:user)
      UserAgent.save(user)

      response = UserAgent.get(user.id)

      expected_response =
        {:ok,
         %User{
           cpf: "12345678900",
           email: "mauricio@server.com",
           id: user.id,
           name: "Mauricio"
         }}

      assert response == expected_response
    end

    test "when the user is not found, return an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found with id=00000000000"}

      assert response == expected_response
    end
  end

  describe "get_all/0" do
    setup do
      UserAgent.start_link()

      :ok
    end

    test "returns all users" do
      user = build(:user, id: "1d0baa7a-320f-47cb-9a58-f13f86f69522")
      UserAgent.save(user)

      response = UserAgent.get_all()

      expected_response = %{
        "1d0baa7a-320f-47cb-9a58-f13f86f69522" => %User{
          cpf: "12345678900",
          email: "mauricio@server.com",
          id: "1d0baa7a-320f-47cb-9a58-f13f86f69522",
          name: "Mauricio"
        }
      }

      assert response == expected_response
    end
  end
end
