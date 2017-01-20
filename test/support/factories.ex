defmodule Notebook.Factory do
  use ExMachina.Ecto, repo: Notebook.Repo

  def note_factory do
    %Notebook.Note{
      name: "Test Note",
      note_html: "<h2>Test</h2>",
      book: build(:book)
    }
  end

  def book_factory do
    %Notebook.Book{
      name: "Test Book"
    }
  end
end
