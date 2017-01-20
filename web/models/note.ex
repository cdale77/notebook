defmodule Notebook.Note do
  use Notebook.Web, :model

  schema "notes" do
    field :name,      :string, default: ""
    field :note_html, :string, default: ""
    belongs_to :book, Notebook.Book
    timestamps()
  end

  @required_fields []

  @doc """
    Note changeset. No fields required.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
