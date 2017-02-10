defmodule Notebook.Api.V1.NoteController do
  use Notebook.Web, :controller
  alias Notebook.{Repo, Note, Book}

  plug Guardian.Plug.EnsureAuthenticated,
       handler: Notebook.Api.V1.SessionController

  plug :scrub_params, "note" when action in [:create, :update]

  def show(conn, %{"id" => id, "book_id" => book_id}) do
    note = Note |> Repo.get_by(id: id, book_id: book_id)
    conn
    |> put_status(:ok)
    |> render("show.json", note: note)
  end

  def index(conn, %{"book_id" => book_id}) do
    notes = Note
    |> where([n], n.book_id == ^book_id)
    |> Repo.all

    conn
    |> put_status(:ok)
    |> render("index.json", notes: notes)
  end

  def create(conn, %{"note" => note_params, "book_id" => book_id}) do
    changeset = Repo.get(Book, book_id)
    |> build_assoc(:notes)
    |> Note.changeset(note_params)

    case Repo.insert(changeset) do
      {:ok, note} ->
        conn
        |> put_status(:created)
        |> render("show.json", note: note)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: changeset.errors)
    end
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    existing_note = Repo.get(Note, id)
    changeset = Note.changeset(existing_note, note_params)

    case Repo.update(changeset) do
      {:ok, note} ->
        conn
        |> put_status(:ok)
        |> render("show.json", note: note)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: changeset.errors)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Repo.get(Note, id)
    Repo.delete!(note)

    conn
    |> put_status(:ok)
    |> render("success.json", message: "Deleted note")
  end
end
