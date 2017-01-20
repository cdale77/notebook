defmodule Notebook.BookTest do
  use Notebook.ModelCase
  import Notebook.Factory
  alias Notebook.Book

  @valid_attrs %{name: "test"}

  describe "relationships" do
    test "user relationship" do
      user = build(:user) |> set_password("password1234") |> insert()
      book = insert(:book, user: user)
      book = Book
      |> Repo.get(book.id)
      |> Repo.preload(:user)

      assert book.user_id == user.id
    end

    @tag :skip
    test "notes relationship" do
      book = insert(:book)
      insert(:note, book: book)
      insert(:note, book: book)
      insert(:note)

      book = Book
      |> Repo.get(book.id)
      |> Repo.preload(:notes)

      assert Enum.count(book.notes) == 2
    end
  end

  describe "changeset" do
    test "changset with valid attributes" do
      changeset = Book.changeset(%Book{}, @valid_attrs)
      assert changeset.valid?
    end
  end
end
