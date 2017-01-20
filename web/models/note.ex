defmodule Notebook.Note do
  use Notebook.Web, :model

  schema "notes" do
    field :name,      :string, default: ""
    field :note_html, :text,   default: ""
    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(name note_html)

  @doc """
    Note changeset. No fields required.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
