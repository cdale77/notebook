defmodule Notebook.Note do
  use Notebook.Web, :model

  schema "notes" do
    field :name,      :string, default: ""
    field :note_html, :string, default: ""
    timestamps()
  end

  @required_fields ~w()

  @doc """
    Note changeset. No fields required.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
