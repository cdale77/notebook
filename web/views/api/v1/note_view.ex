defmodule Notebook.Api.V1.NoteView do
  use Notebook.Web, :view

  def render("show.json", %{note: note}) do
    %{
      data: %{
        note: %{
          id: note.id,
          name: note.name,
          note_html: note.note_html,
          created_at: note.inserted_at,
          updated_at: note.updated_at
        }
      }
    }
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
end
