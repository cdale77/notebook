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
      name: "Test Book",
      user: build(:user) |> set_password("password1234")
    }
  end

  def user_factory do
    %Notebook.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
    }
  end

  def set_password(user, password) do
    user
    |> Notebook.User.changeset(%{"password" => password})
    |> Ecto.Changeset.apply_changes()
  end
end
