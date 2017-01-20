defmodule Notbook.NoteTest do
  use Notebook.ModelCase
  import Notebook.Factory
  alias Notebook.Note

  @valid_attrs %{name: "", note_text: ""}

  test "changeset with valid attributes" do
    changeset = Note.changeset(%Note{}, @valid_attrs)
    assert changeset.valid?
  end

  test "book relationship" do
    book = insert(:book)
    note = insert(:note, book: book)

    note = Note
    |> Repo.get(note.id)
    |> Repo.preload(:book)

    assert note.book_id == book.id
  end
end
