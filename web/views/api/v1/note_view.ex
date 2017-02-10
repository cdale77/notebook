defmodule Notebook.Api.V1.NoteView do
  use Notebook.Web, :view

  def render("show.json", %{note: note}) do
    %{data: %{note: render("one.json", %{note: note})}}
  end

  def render("index.json", %{notes: notes}) do
    %{data: %{notes: render_many(notes, Notebook.Api.V1.NoteView, "one.json")}}
  end

  def render("delete.json", %{message: message}) do
    %{message: message}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("success.json", %{message: message}) do
    %{message: message}
  end

  def render("one.json", %{note: note}) do
    %{
      id: note.id,
      book_id: note.book_id,
      name: note.name,
      note_html: note.note_html,
      created_at: note.inserted_at,
      updated_at: note.updated_at
    }
  end
end
