defmodule Shop.Products.ProductService do
  alias Shop.{Products, Products.Product}

  def all do
    case Products.all() do
      {:ok, _product} = success -> success
      error -> error
    end
  end

  def show(params) do
    with {:ok, id} <- Shop.Validation.get_required_field(params, "id"),
         {:ok, _id} <- Shop.Validation.is_integer(id, "id"),
         {:ok, product} <- Products.get(id) do
      {:ok, Product.to_json!(product)}
    else
      {:error, _reason} = failure -> failure
    end
  end
end
