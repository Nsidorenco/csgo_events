defmodule Api.Web.EventController do
  use Api.Web, :controller

  alias Api.Web.EventList
  alias Api.Web.EventList.Event

  action_fallback Api.Web.FallbackController

  def index(conn, _params) do
    events = CsgoEvents.get_events
    render(conn, "index.json", events: events)
  end
end
