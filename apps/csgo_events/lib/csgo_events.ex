defmodule CsgoEvents do
  alias CsgoEvents.{Filter, Builder}

  defdelegate filter_prize(events, mix_prize), to: Filter
  defdelegate filter_type(events, type), to: Filter
  defdelegate get_events, to: Builder

end
