defmodule CsgoEvents.Event do
  @moduledoc """
    csgo event representation
  """

  defstruct [:event_name,
             :event_start,
             :event_end,
             :event_prize,
             :event_type]
end
