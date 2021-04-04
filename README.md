# Flightex

This module contains methods to simulate a flight booking application, using Elixir's Agent to persist data.

This is [challenge #1](https://www.notion.so/Desafio-01-Reservas-de-voos-f5fd8814ce904360b2500449143e589e) of Rocketseat's Ignite Elixir module 3.

## Usage

Once inside the project's directory, you can run it using Elixir's interactive shell:

```shell
$ iex -S mix
iex(1)> Flightex.start_agents()
```
### Creating an user

```elixir
iex(2)> user_data = user_parameters = %{name: "Mauricio", email: "mauricio@server.com", cpf: "12345678900"}
iex(3)> Flightex.create_user(user_data)
{:ok, "27b76e60-4a65-468d-8f51-6c7db5d433e1"}
```

### Creating a flight booking

```elixir
iex(4)> booking_data = %{
  cidade_destino: "Berlim",
  cidade_origem: "São Paulo",
  data_completa: ~N[2021-04-02 17:13:00]
}
iex(5)> Flightex.create_booking("27b76e60-4a65-468d-8f51-6c7db5d433e1", booking_data)
{:ok, "5757a69e-b4d0-48af-918c-0c0f656f697e"}
```

### Retrieving flight booking by Id

```elixir
iex(6)> Flightex.get_booking("5757a69e-b4d0-48af-918c-0c0f656f697e")
```

## Tests

You can also run the tests script in the terminal (outside `iex`):

```shell
$ mix test
```
