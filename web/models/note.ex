defmodule Notebook.Note do
  use Notebook.Web, :model

  schema "notes" do
    field :name,      :string, default: ""
    field :note_html, :string, default: ""
    belongs_to :book, Notebook.Book
    timestamps()
  end

  @doc """
    Note changeset. Fields required:
    * name: string
    * note_html: text
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :note_html])
    |> validate_required(:name)
  end
end
