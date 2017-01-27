defmodule Notebook.Api.V1.NoteController do
  use Notebook.Web, :controller
  alias Notebook.{Repo, Note}

  plug Guardian.Plug.EnsureAuthenticated,
       handler: Notebook.Api.V1.SessionController

  plug :scrub_params, "note" when action in [:create, :update]

  def show(conn, %{"id" => id}) do
    note = Repo.get(Note, id)
    conn
    |> put_status(:ok)
    |> render("show.json", note: note)
  end

  def index(conn, %{}) do
    notes = Repo.all(Note)
    conn
    |> put_status(:ok)
    |> render("index.json", notes: notes)
  end

  def create(conn, %{"note" => note_params}) do
    changeset = Note.changeset(%Note{}, note_params)
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
