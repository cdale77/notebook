defmodule Notebook.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string, default: ""

      timestamps()
    end
  end
end
