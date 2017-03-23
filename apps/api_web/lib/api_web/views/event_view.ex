defmodule Api.Web.EventView do
  use Api.Web, :view
  alias Api.Web.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{event_name: event.event_name,
      event_type: event.event_type,
      event_prize: event.event_prize,
      event_start: event.event_start,
      event_end: event.event_end}
  end
end
