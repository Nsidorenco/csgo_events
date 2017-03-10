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
    {:ok, fetch_data!()}
  end


  def handle_call(:fetch, _from, state) do
    {:reply, state, state}
  end



  def fetch_data! do
    get!("http://www.hltv.org/events/upcoming/").body
    |> Floki.parse
  end
end
