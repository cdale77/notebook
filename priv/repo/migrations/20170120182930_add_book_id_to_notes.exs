defmodule Notebook.Repo.Migrations.AddBookIdToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add :book_id, references(:books, on_delete: :delete_all)
    end

    create index(:notes, [:book_id])
  end
end
