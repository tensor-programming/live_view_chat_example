defmodule Livechat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :string
      add :username, :string

      timestamps()
    end

  end
end
