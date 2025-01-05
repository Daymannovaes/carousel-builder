defmodule CarouselBuilderWeb.Helpers do
  @moduledoc """
  A collection of reusable helper functions for various tasks in the application.
  """

  def id_is_valid?(id) when is_binary(id) do
    case Integer.parse(id) do
      {int, ""} when int > 0 -> true
      _ -> false
    end
  end

  def id_is_valid?(_id), do: false
end
