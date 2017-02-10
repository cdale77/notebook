defmodule Notebook.Api.V1.BookController do
  use Notebook.Web, :controller
  alias Notebook.{Repo, Book}

  plug Guardian.Plug.EnsureAuthenticated,
       handler: Notebook.Api.V1.SessionController

  plug :scrub_params, "book" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    book = Repo.get(Book, id)
    conn
    |> put_status(:ok)
    |> render("show.json", book: book)
  end

  def index(conn, %{}) do
    books = Repo.all(Book)
    conn
    |> put_status(:ok)
    |> render("index.json", books: books)
  end

  def create(conn, %{"book"=> book_params}) do
    changeset = Book.changeset(%Book{}, book_params)
    case Repo.insert(changeset) do
      {:ok, book} ->
        conn
        |> put_status(:created)
        |> render("show.json", book: book)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    existing_book = Repo.get(Book, id)
    changeset = Book.changeset(existing_book, book_params)

    case Repo.update(changeset) do
      {:ok, book} ->
        conn
        |> put_status(:ok)
        |> render("show.json", book: book)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: changeset.errors)
    end
  end
end
