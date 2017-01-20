defmodule Notbook.NoteTest do
  use Notebook.ModelCase
  alias Notebook.Note

  @valid_attrs %{name: "", note_text: ""}

  test "changeset with valid attributes" do
    changeset = Note.changeset(%Note{}, @valid_attrs)
    assert changeset.valid?
  end
end
