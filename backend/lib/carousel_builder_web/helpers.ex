defmodule CarouselBuilderWeb.Helpers do
  @moduledoc """
  A collection of reusable helper functions for various tasks in the application.
  """

  def value_is_positive_integer?(value) when is_integer(value) do
    value > 0
  end

  def value_is_positive_integer?(value) when is_binary(value) do
    case Integer.parse(value) do
      {int, ""} when int > 0 -> true
      _ -> false
    end
  end

  def value_is_positive_integer?(_value), do: false
end
