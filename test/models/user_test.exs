defmodule Notebook.UserTest do
  use Notebook.ModelCase
  import Notebook.Factory
  alias Notebook.User

  @valid_attrs %{ email: "user@exampl.com",
                  password: "password1234",
                  password_confirmation: "password1234"}

  describe "relationships" do
    test "books relationship" do
      user = build(:user) |> set_password("password1234") |> insert()
      insert(:book, user: user)
      insert(:book, user: user)
      insert(:book)

      user = User
      |> Repo.get(user.id)
      |> Repo.preload(:books)

      assert Enum.count(user.books) == 2
    end
  end

  describe "emails" do
    test "unique emails" do
      user = build(:user) |> set_password("password1234") |> insert()

      user_attrs = %{email: user.email,
                     passord: "password1234",
                     password_confirmation: "password1234"}

      changeset = User.changeset(%User{}, user_attrs)
      refute changeset.valid?
    end
  end

  describe "passwords" do
    test "setting the encrypted_password attribute" do
      {:ok, user} = %User{}
      |> User.changeset(@valid_attrs)
      |> Repo.insert

      user = Repo.get(User, user.id)

      assert String.trim(user.encrypted_password) != ""
    end
  end

  describe "changesets" do
    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with blank email" do
      invalid_attrs = %{email: "",
                        password: "password1234",
                        password_confirmation: "pasword1234"}
      changeset = User.changeset(%User{}, invalid_attrs)
      refute changeset.valid?
    end

    test "changeset with blank password" do
      invalid_attrs = %{email: "test@example.com",
                        password: "",
                        password_confirmation: ""}
      changeset = User.changeset(%User{}, invalid_attrs)
      refute changeset.valid?
    end

    test "changeset with blank password confirmation" do
      invalid_attrs = %{email: "test@example.com",
                        password: "password1234",
                        password_confirmation: ""}
      changeset = User.changeset(%User{}, invalid_attrs)
      refute changeset.valid?
    end

    test "changeset with incorrect password confirmation" do
      invalid_attrs = %{email: "test@example.com",
                        password: "password1234",
                        password_confirmation: "wrong"}
      changeset = User.changeset(%User{}, invalid_attrs)
      refute changeset.valid?
    end
  end
end
