defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys

  defstruct @keys

  def build(id_usuario, %NaiveDateTime{} = data_completa, cidade_origem, cidade_destino)
      when is_bitstring(id_usuario) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end

  def build(_id_usuario, _data_completa, _cidade_origem, _cidade_destino),
    do: {:error, "Invalid parameters"}
end
