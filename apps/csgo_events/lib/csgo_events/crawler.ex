defmodule CsgoEvents.Crawler do
  import HTTPoison

  @moduledoc false

  
  #Fetches raw HTML-data and parses it with Floki
  @spec fetch_data! :: String.t
  def fetch_data! do
    get!("http://www.hltv.org/events/upcoming/").body
    |> Floki.parse
  end
end
