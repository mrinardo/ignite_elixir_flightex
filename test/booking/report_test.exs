defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report

  describe "generate/3" do
    setup do
      BookingAgent.start_link()

      booking = build(:booking)

      booking1 =
        build(:booking, data_completa: ~N[2021-05-05 17:13:00], cidade_destino: "Munique")

      BookingAgent.save(booking)
      BookingAgent.save(booking1)

      {:ok, booking: booking1}
    end

    test "generates the report", %{booking: booking} do
      filename = "test_report.csv"

      Report.generate(~D[2021-05-01], ~D[2021-05-10], filename)

      {:ok, content} = File.read("reports/#{filename}")

      expected_content =
        "#{booking.id_usuario},#{booking.cidade_origem},#{booking.cidade_destino},#{
          booking.data_completa
        }\n"

      assert content == expected_content
    end
  end
end
