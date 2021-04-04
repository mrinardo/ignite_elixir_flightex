defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(from_date, to_date, filename \\ "report.csv") do
    bookings_list = build_booking_list(from_date, to_date)

    case File.write("reports/#{filename}", bookings_list) do
      :ok -> {:ok, "Report generated successfully"}
      error -> error
    end
  end

  defp build_booking_list(from_date, to_date) do
    BookingAgent.get_all_by_date(from_date, to_date)
    |> Enum.map(&create_line(&1))
  end

  defp create_line(
         {_id,
          %Booking{
            data_completa: data_completa,
            cidade_origem: cidade_origem,
            cidade_destino: cidade_destino,
            id_usuario: id_usuario
          }}
       ) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end
end
