defmodule Shop.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  @table_name "products"

  def change do
    create table(@table_name) do
      add :title, :string
      add :description, :string
      add :price, :integer, default: 0

      timestamps()
    end
  end
end
