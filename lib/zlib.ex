defmodule ExPlantuml.Zlib do
  @moduledoc """
  zlib module.
  """
  @doc """
  exec deflate compression.

  ## Examples

      iex> deflate("0")
      <<120, 218, 51, 0, 0, 0, 49, 0, 49>>

  """
  def deflate(data) do
    z = :zlib.open()
    :ok = :zlib.deflateInit(z, 9)
    [compressed] = :zlib.deflate(z, data, :finish)
    :zlib.deflateEnd(z)
    :zlib.close(z)

    compressed
  end
end
