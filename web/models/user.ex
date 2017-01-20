defmodule Notebook.User do
  use Notebook.Web, :model

  schema "users" do
    field :email,                 :string, null: false
    field :encrypted_password,    :string, null: false
    field :password,              :string, virtual: :true
    field :password_confirmation, :string, virtual: :true
    has_many :books, Notebook.Book

    timestamps()
  end

  @required_fields [:email, :password]

  @doc """
    User changeset. Fields email and password required
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:email, min: 1)
    |> validate_length(:password, min: 1)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email has already been taken")
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  defimpl Poison.Encoder, for: Notebook.User do
    def encode(model, opts) do
      model
      |> Map.take([:id, :email])
      |> Poison.Encoder.encode(opts)
    end
  end
end
