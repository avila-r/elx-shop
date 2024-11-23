defmodule ShopWeb.ProductsController do
  use ShopWeb, :controller

  alias ShopWeb.ErrorJSON
  alias Shop.Products.Product
  alias Shop.Products.ProductService

  def show(conn, params) do
    case ProductService.show(params) do
      {:ok, product} ->
        conn
        |> json(product |> Product.to_json!())

      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> put_view(json: ErrorJSON)
        |> render(:error, message: reason)
    end
  end

  def create(conn, params) do
    case ProductService.create(params) do
      {:ok, product} ->
        conn
        |> put_status(:created)
        |> json(product |> Product.to_json!())

      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> put_view(json: ErrorJSON)
        |> render(:error, changeset: changeset)
    end
  end

  def update(conn, params) do
    case ProductService.update(params) do
      {:ok, patched} ->
        conn |> json(patched |> Product.to_json!())

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> put_view(json: ErrorJSON)
        |> render(:error, message: reason)
    end
  end

  def delete(conn, params) do
    case ProductService.delete(params) do
      {:ok} ->
        conn |> json(%{message: "successfully deleted"})

      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> put_view(json: ErrorJSON)
        |> render(:error, message: reason)
    end
  end
end
