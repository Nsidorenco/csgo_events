defmodule CsgoEvents.Event do
  @moduledoc """
  csgo event representation
  """

  defstruct [:event_name,
             :event_start,
             :event_end,
             :event_prize,
             :event_type]

 @type t :: %CsgoEvents.Event{
                  event_name: String.t,
                  event_start: Date.t,
                  event_end: Date.t,
                  event_prize: number,
                  event_type: String.t
                }
end
