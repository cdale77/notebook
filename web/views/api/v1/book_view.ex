defmodule Notebook.Api.V1.BookView do
  use Notebook.Web, :view

  def render("show.json", %{book: book}) do
    %{data: %{book: render("one.json", %{book: book})}}
  end

  def render("index.json", %{books: books}) do
    %{data: %{books: render_many(books, Notebook.Api.V1.BookView, "one.json")}}
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

  def render("one.json", %{book: book}) do
    %{
      id: book.id,
      name: book.name,
      created_at: book.inserted_at,
      updated_at: book.updated_at
    }
  end
end
