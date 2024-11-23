defmodule Shop.Validation do
  def get_required_field(params, field) do
    case params[field] do
      nil -> {:error, "field #{field} is required"}
      value -> {:ok, value}
    end
  end

  def is_integer(value, field) do
    case Integer.parse(value) do
      {i, _} -> {:ok, i}
      _ -> {:error, "#{field}: value isn't an integer"}
    end
  end
end
