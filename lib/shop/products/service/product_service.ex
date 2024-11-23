defmodule Shop.Products.ProductService do
  alias Shop.Products

  def all do
    case Products.all() do
      {:ok, _product} = success -> success
      error -> error
    end
  end

  def show(params) do
    with {:ok, id} <- Shop.Validation.get_required_field(params, "id"),
         {:ok, _id} <- Shop.Validation.is_integer(id, "id"),
         {:ok, _product} = success <- Products.get(id) do
      success
    else
      {:error, _reason} = failure -> failure
    end
  end

  def create(params) do
    Products.insert(params)
  end

  def update(params) do
    with {:ok, product} <- Products.get(params),
         {:ok, _patched} = success <- product |> Products.update(params) do
      success
    else
      {:error, _reason} = failure -> failure
    end
  end

  def delete(params) do
    with {:ok, product} <- Products.get(params),
         {:ok, _} <- Products.delete(product.id) do
      {:ok}
    else
      {:error, _reason} = failure -> failure
    end
  end
end
