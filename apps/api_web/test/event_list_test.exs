defmodule Api.Web.EventListTest do
  use Api.Web.DataCase

  alias Api.Web.EventList
  alias Api.Web.EventList.Event

  @create_attrs %{event_end: ~D[2010-04-17], event_name: "some event_name", event_prize: 42, event_start: ~D[2010-04-17], event_type: "some event_type"}
  @update_attrs %{event_end: ~D[2011-05-18], event_name: "some updated event_name", event_prize: 43, event_start: ~D[2011-05-18], event_type: "some updated event_type"}
  @invalid_attrs %{event_end: nil, event_name: nil, event_prize: nil, event_start: nil, event_type: nil}

  def fixture(:event, attrs \\ @create_attrs) do
    {:ok, event} = Web.EventList.create_event(attrs)
    event
  end

  test "list_events/1 returns all events" do
    event = fixture(:event)
    assert Web.EventList.list_events() == [event]
  end

  test "get_event! returns the event with given id" do
    event = fixture(:event)
    assert Web.EventList.get_event!(event.id) == event
  end

  test "create_event/1 with valid data creates a event" do
    assert {:ok, %Event{} = event} = Web.EventList.create_event(@create_attrs)
    assert event.event_end == ~D[2010-04-17]
    assert event.event_name == "some event_name"
    assert event.event_prize == 42
    assert event.event_start == ~D[2010-04-17]
    assert event.event_type == "some event_type"
  end

  test "create_event/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Web.EventList.create_event(@invalid_attrs)
  end

  test "update_event/2 with valid data updates the event" do
    event = fixture(:event)
    assert {:ok, event} = Web.EventList.update_event(event, @update_attrs)
    assert %Event{} = event
    assert event.event_end == ~D[2011-05-18]
    assert event.event_name == "some updated event_name"
    assert event.event_prize == 43
    assert event.event_start == ~D[2011-05-18]
    assert event.event_type == "some updated event_type"
  end

  test "update_event/2 with invalid data returns error changeset" do
    event = fixture(:event)
    assert {:error, %Ecto.Changeset{}} = Web.EventList.update_event(event, @invalid_attrs)
    assert event == Web.EventList.get_event!(event.id)
  end

  test "delete_event/1 deletes the event" do
    event = fixture(:event)
    assert {:ok, %Event{}} = Web.EventList.delete_event(event)
    assert_raise Ecto.NoResultsError, fn -> Web.EventList.get_event!(event.id) end
  end

  test "change_event/1 returns a event changeset" do
    event = fixture(:event)
    assert %Ecto.Changeset{} = Web.EventList.change_event(event)
  end
end
