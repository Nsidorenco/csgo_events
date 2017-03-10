defmodule CsgoEventBot do
  alias CsgoEventBot.{Parser, Crawler}

  def main do
    Crawler.fetch
    |> Parser.process_response_body
  end

end
