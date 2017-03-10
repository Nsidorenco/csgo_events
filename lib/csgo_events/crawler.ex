defmodule CsgoEvents.Crawler do
  import HTTPoison
  use GenServer

  # Client API
  def start_link() do
    GenServer.start_link(__MODULE__, :ok)
  end

  def fetch(pid) do
    GenServer.call(pid, :fetch)
  end

  #Server API
  def init(_args) do
    Process.send_after(self(), :started, 0)
    {:ok, []}
  end

  def handle_info(:started, _) do
    Process.send_after(self(), :update, 28800000)
    {:noreply, fetch_data!()}
  end

  def handle_info(:update, _state) do
    Process.send_after(self(), :update, 28800000)
    {:noreply, fetch_data!()}
  end



  def handle_call(:fetch, _from, state) do
    {:reply, state, state}
  end



  def fetch_data! do
    get!("http://www.hltv.org/events/upcoming/").body
    |> Floki.parse
  end
end
