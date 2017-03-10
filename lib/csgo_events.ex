defmodule CsgoEvents do
  alias CsgoEvents.{Parser, Crawler}

  def main do
    Crawler.fetch_data!
    |> Parser.process_response_body
  end

end
