defmodule Notebook.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :name,      :string, default: ""
      add :note_html, :text,   default: ""
      timestamps()
    end
  end
end
