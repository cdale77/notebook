defmodule Notebook.Book do
  use Notebook.Web, :model

  schema "books" do
    field :name, :string, default: ""
    has_many :notes, Notebook.Note
    belongs_to :user, Notebook.User
    timestamps()
  end

  @doc """
    Book changeset. Name field required.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name])
    |> validate_required(:name)
  end
end
