defmodule CsgoEvents.Filter do

  @moduledoc """
  Provides functions for filtering events from the event list
  """

  @doc """
  Takes a *list of events* and removes all events below a set minimum prize

  ## Parameters
    - events: List which contains Event structs
    - min_prize: Number which the `:event_prize` must be above

  ## Examples

    `iex> CsgoEvents.Filter.filter_prize([%Event{event_prize: 20}], 21)`
    `[]`

    `iex> CsgoEvents.Filter.filter_prize([%Event{event_prize: 20}], 19)`
    `[%Event{event_prize: 20}]`

  """
  @spec filter_prize([CsgoEvents.Event.t, ...], number) :: [CsgoEvents.Event.t]
  def filter_prize(events, min_prize) do
    events
    |> Enum.filter(&(&1.event_prize) >= min_prize)
    |> Enum.filter(&(&1.event_prize) != nil)
  end

  @doc """
  Takes a list of Events and filters them based on `:event_type`

  ## Parameters

    - events: List which contains Event structs

    - type: String that is either "LAN" or something else
  """

  @spec filter_type([CsgoEvents.Event.t, ...], String.t) :: [CsgoEvents.Event.t]
  def filter_type(events, "LAN") do
    events
    |> Enum.filter(&(&1.event_type) === "LAN")
  end

  def filter_type(events, _) do
    events
    |> Enum.filter(&(&1.event_type) !== "LAN")
  end
end
