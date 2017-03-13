defmodule CsgoEvents.Builder do
  alias CsgoEvents.{Crawler, Parser}
  use GenServer

  @moduledoc """
    GenServer which stores the event list and updates the list every 16 hours
  """

  # Client API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :event_builder)
  end

  @spec get_events :: list
  def get_events do
    GenServer.call(:event_builder, :build)
  end

  # Server API
  def init(_args) do
    Process.send_after(self(), :started, 0)
    {:ok, []}
  end

  def handle_info(:started, _) do
    Process.send_after(self(), :update, 28800000*2)
    {:noreply, generate_event_list()}
  end

  def handle_info(:update, _state) do
    Process.send_after(self(), :update, 28800000*2)
    {:noreply, generate_event_list()}
  end

  def handle_call(:build, _from, state) do
    {:reply, state, state}
  end

  # Remote fetching
  @spec generate_event_list :: list
  def generate_event_list do
    Crawler.fetch_data!
    |> Parser.parse
  end
end
