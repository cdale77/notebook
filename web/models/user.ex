defmodule Notebook.User do
  use Notebook.Web, :model

  schema "users" do
    field :email,                 :string, null: false
    field :encrypted_password,    :string, null: false
    field :password,              :string, virtual: :true
    field :password_confirmation, :string, virtual: :tru
  end

  @required_fields [:email, :password]

  @doc """
    User changeset. Fields email and password required
  """

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
