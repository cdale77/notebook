defmodule Notebook.BookTest do
  use Notebook.ModelCase
  import Notebook.Factory
  alias Notebook.Book

  @valid_attrs %{name: "test"}

  test "changset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

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
