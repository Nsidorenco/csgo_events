defmodule Api.Web.EventList.Event do
  use Ecto.Schema

  schema "event_list_events" do
    field :event_end, :date
    field :event_name, :string
    field :event_prize, :integer
    field :event_start, :date
    field :event_type, :string

    timestamps()
  end
end
