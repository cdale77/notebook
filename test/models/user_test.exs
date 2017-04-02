defmodule Notebook.UserTest do
  use Notebook.ModelCase
  import Notebook.Factory
  alias Notebook.User

  @valid_attrs %{ email: "user@exampl.com",
                  password: "password1234",
                  password_confirmation: "password1234"}

  setup do
    user = build(:user) |> set_password("password1234") |> insert()
    {:ok, %{user: Repo.get(User, user.id)}}
  end

  describe "emails" do
    test "unique emails", %{user: user} do
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

  describe "find_and_confirm_password/2" do
    test "with a correct email and password", %{user: user} do
      response = User.find_and_confirm_password(user.email, "password1234")

      assert {:ok, user} == response
    end

    test "with an incorrect email and correct password" do
      response = User.find_and_confirm_password("foo", "password1234")

      assert {:error} == response
    end

    test "with a correct email and incorrect password", %{user: user} do
      response = User.find_and_confirm_password(user.email, "wrong")

      assert {:error} == response
    end
  end
end
