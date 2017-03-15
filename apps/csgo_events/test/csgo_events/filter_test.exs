defmodule CsgoEvents.FilterTest do
  alias CsgoEvents.{Filter, Event}
  use ExUnit.Case
  doctest Filter


  def events do
    [%Event{event_prize: 100,
            event_type: "LAN"},
     %Event{event_prize: 99,
            event_type: "not LAN"}]
  end

  test "filter_prize/2 with all prizes below min should return []" do
    assert Filter.filter_prize(events(), 101) == []
  end

  test "filter_prize/2 with one event over limit" do
    assert Filter.filter_prize(events(), 100) == [Enum.at(events(), 0)]
  end

  test "filter_prize/2 with all over limit" do
    assert Filter.filter_prize(events(), 0) == events()
  end

  test "filter_type/2 with LAN type should only return lan events" do
    assert Filter.filter_type(events(), "LAN") == [Enum.at(events(), 0)]
  end

  test "filter_type/2 with different type than LAN" do
    assert Filter.filter_type(events(), 1) == [Enum.at(events(), 1)]
  end
end
