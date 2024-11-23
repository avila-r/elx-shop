defmodule Shop.Products.Product do
  use Ecto.Schema

  alias Ecto.Changeset

  @required_params [:title, :description]

  schema "products" do
    field :title, :string
    field :description, :string
    field :price, :integer, default: 0
  end

  def changeset(struct \\ %__MODULE__{}, params),
    do:
      struct
      |> Changeset.cast(params, @required_params ++ [:price])
      |> Changeset.validate_required(@required_params)

  @spec to_json!(map(), :protected) :: map()
  def to_json!(struct, permission) when permission == :protected,
    do: struct |> Map.take([:title, :description, :price])

  @spec to_json!(map()) :: map()
  def to_json!(struct),
    do: struct |> Map.take([:id, :title, :description, :price, :inserted_at, :updated_at])
end
