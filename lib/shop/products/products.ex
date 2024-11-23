defmodule Shop.Products do
  alias Shop.Repo
  alias Shop.Products.Product

  def all do
    with products when products != [] <- Product |> Repo.all() do
      {:ok, products}
    else
      [] -> {:error, "no products found"}
      _ -> {:error, "unexpected error occurred"}
    end
  end

  def get(id) do
    case Product |> Repo.get(id) do
      nil -> {:error, "product not found"}
      product -> {:ok, product}
    end
  end

  def delete(id) do
    case get(id) do
      {:ok, product} -> Repo.delete(product)
      {:error, _reason} = failure -> failure
    end
  end

  def insert(%{"id" => id} = new) do
    case get(id) do
      {:ok, _product} ->
        {:error, message: "product already exists"}

      {:error, _reason} ->
        changeset = new |> Product.changeset()

        case changeset do
          %Ecto.Changeset{valid?: true} -> Repo.insert(changeset)
          _ -> {:error, changeset}
        end
    end
  end

  def update(struct, params) do
    struct
    |> Product.changeset(params)
    |> Repo.update()
  end
end
