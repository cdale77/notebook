defmodule Notebook.Book do
  use Notebook.Web, :model

  schema "books" do
    field :name, :string, default: ""
    has_many :notes, Notebook.Note
    timestamps()
  end

  @required_fields ~w()

  @doc """
    Book changeset. No fields required.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
