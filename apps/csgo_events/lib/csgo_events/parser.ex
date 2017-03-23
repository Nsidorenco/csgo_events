defmodule CsgoEvents.Parser do
  alias CsgoEvents.Event

  @moduledoc false

  # Builds a list of events from the raw HTML
  @spec parse(String.t) :: [CsgoEvents.Event.t]
  def parse(body) do
    body
    |> Floki.find(".wrapper")
    |> build_event_list
  end

  defp build_event_list(body) do
    body
    |> build_event_list(0,[])
  end

  defp build_event_list(body, curr, acc) when curr >= length(body), do: acc
  defp build_event_list(body, curr, acc) do
    build_event_list(body, curr+1, [build_event_map(Enum.at(body,curr)) | acc])
  end

  # calls all helper functions and creates a Event struct
  defp build_event_map(body) do
    %Event{
      event_name:  find_event_name!(body),
      event_type:  find_event_type!(body),
      event_start: find_event_start!(body),
      event_end:   find_event_end!(body),
      event_prize: find_event_prize!(body)
    }
  end

  # recursively climbs though the html until it finds the result for the given keyword
  defp keyword_search!(body, _keyword, curr) when curr >= length(body), do: "no data"
  defp keyword_search!(body, keyword, curr) do
    string = Floki.text(Enum.at(body,curr))
    if String.slice(string, 0, String.length(keyword)) == keyword do
      String.slice(string, String.length(keyword), String.length(string))
    else
      keyword_search!(body, keyword, curr+1)
    end
  end

  # Find the starting date of the event
  defp find_event_start!(body) do
    body
    |> Floki.find("div")
    |> keyword_search!("Start:",0)
    |> parse_date
  end

  # Find the end date of the event
  defp find_event_end!(body) do
    body
    |> Floki.find("div")
    |> keyword_search!("End:",0)
    |> parse_date
  end

  # Finds the prize pool and converts it to a integer
  defp find_event_prize!(body) do
    body
    |> Floki.find("div")
    |> keyword_search!("Prize:",0)
    |> String.replace(~r/[\D]/,"")
    |> Integer.parse
    |> case do
        {int, _} -> int
        _       -> nil
      end
  end

  # Finds and returns the name of the event
  defp find_event_name!(body) do
    body
    |> Floki.find(".eventheadline")
    |> Floki.text
    |> :unicode.characters_to_binary(:latin1, :utf8)
  end

  # Finds and returns the type of event
  defp find_event_type!(body) do
    body
    |> Floki.find(".ribbon-wrapper")
    |> Floki.text
  end

  # Parses string representation of a Data into a Date struct
  defp parse_date(string) do
    list = String.split(string)
    parsedList = Enum.map(list, &parse_date_string/1)

    # Only try to create a date if the string representation exists
    with [day, _, month, year | _ ] <- parsedList
    do
      {:ok, date} = Date.new(year, parse_month(month), day)
      # no need to return the tuple
      date
    else
      _ -> :no_date
    end
  end

  # Converts string representation of integer to an integer
  defp parse_date_string(string) do
    case Integer.parse(string) do
      {integer, _} -> integer
      _            -> string
    end
  end

  # Converts the string representation of a month to an integer
  defp parse_month(string) do
    case string do
      "January"   -> 1
      "February"  -> 2
      "March"     -> 3
      "April"     -> 4
      "May"       -> 5
      "June"      -> 6
      "July"      -> 7
      "August"    -> 8
      "September" -> 9
      "October"   -> 10
      "November"  -> 11
      "December"  -> 12
      _           -> nil
    end
  end
end
