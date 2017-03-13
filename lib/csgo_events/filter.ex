defmodule CsgoEvents.Filter do

  @moduledoc """
    functions for filtering events from the event list
  """

  @doc """
    Takes a list of Events and removes all events below a set minimul prize
  """
  @spec filter_prize([%CsgoEvents.Event{}], number) :: list
  def filter_prize(events, min_prize) do
    events
    |> Enum.filter(&(&1.event_prize) >= min_prize)
    |> Enum.filter(&(&1.event_prize) != nil)
  end

  @doc """
    Takes a list of Events and filters them based on the event type
  """

  @spec filter_prize([%CsgoEvents.Event{}], String.t) :: list
  def filter_type(events, "LAN") do
    events
    |> Enum.filter(&(&1.event_type) === "LAN")
  end

  @spec filter_prize([%CsgoEvents.Event{}], String.t) :: list
  def filter_type(events, "") do
    events
    |> Enum.filter(&(&1.event_type) !== "LAN")
  end
end
