defmodule Api.Web.Repo.Migrations.CreateApi.Web.EventList.Event do
  use Ecto.Migration

  def change do
    create table(:event_list_events) do
      add :event_name, :string
      add :event_type, :string
      add :event_prize, :integer
      add :event_start, :date
      add :event_end, :date

      timestamps()
    end

  end
end
