defmodule Notebook.User do
  use Notebook.Web, :model
  alias Notebook.{Repo,User}

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

  @doc """
  Finds a user and checks the supplied password against the stored hash using
  Comeonin.

  Returns `{:ok, user}` if the user is found *and* the password matches. Returns
  `{:error}` if not.
  """
  def find_and_confirm_password(email, password) do
    user = Repo.get_by(User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _    -> {:error}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
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
