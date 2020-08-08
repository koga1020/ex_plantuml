defmodule ExPlantuml do
  @moduledoc """
  PlantUML text encoding.
  """

  alias ExPlantuml.Zlib
  use Bitwise

  @doc """
  encode.

  ## Examples

      iex> encode("Bob->Alice : hello")
      "~1UDfpoa_IjNFCoKnELR1Io4ZDoSa703O41Ui0"

  """
  def encode(data) do
    compressed = Zlib.deflate(data)

    compressed
    |> :binary.bin_to_list()
    |> Enum.chunk_every(3, 3, [0, 0])
    |> Enum.map_join(fn [b1, b2, b3] ->
      c1 = b1 >>> 2
      c2 = (b1 &&& 0x3) <<< 4 ||| b2 >>> 4
      c3 = (b2 &&& 0xF) <<< 2 ||| b3 >>> 6
      c4 = b3 &&& 0x3F

      Enum.join([
        encode6bit(c1 &&& 0x3F),
        encode6bit(c2 &&& 0x3F),
        encode6bit(c3 &&& 0x3F),
        encode6bit(c4 &&& 0x3F)
      ])
    end)
    |> add_header()
  end

  def encode6bit(b) when b < 10, do: <<48 + b>>
  def encode6bit(b) when b - 10 < 26, do: <<65 + b - 10>>
  def encode6bit(b) when b - 10 - 26 < 26, do: <<97 + b - 10 - 26>>
  def encode6bit(b) when b - 10 - 26 - 26 == 0, do: "-"
  def encode6bit(b) when b - 10 - 26 - 26 == 1, do: "_"
  def encode6bit(_), do: "?"

  def add_header(encoded), do: "~1#{encoded}"
end
