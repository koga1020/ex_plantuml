defmodule ExPlantuml.Compression do
  @moduledoc """
  compression module.
  """
  @doc """
  exec deflate compression.

  ## Examples

      iex> deflate("0")
      <<120, 156, 51, 0, 0, 0, 49, 0, 49>>

  """
  def deflate(data) do
    z = :zlib.open()
    :ok = :zlib.deflateInit(z)
    [compressed] = :zlib.deflate(z, data, :finish)
    :zlib.deflateEnd(z)
    :zlib.close(z)

    compressed
  end
end
