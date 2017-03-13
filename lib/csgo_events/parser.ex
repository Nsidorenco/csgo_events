defmodule CsgoEvents.Parser do
  alias CsgoEvents.Event

  @moduledoc """
    Parses the raw HTML data into a list of #{Event} structs
  """

  @doc """
    Converts raw HTML-data of csgo events into a list of Event structs
  """

  @spec parse(String.t) :: list
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
  
  @spec build_event_map(String.t) :: %Event{}
  defp build_event_map(body) do
    %Event{
      event_name:  find_event_name!(body),
      event_type:  find_event_type!(body),
      event_start: find_event_start!(body),
      event_end:   find_event_end!(body),
      event_prize: find_event_prize!(body)
    }
  end

  defp keyword_search!(body, _keyword, curr) when curr >= length(body), do: "no data"
  defp keyword_search!(body, keyword, curr) do
    string = Floki.text(Enum.at(body,curr))
    if String.slice(string, 0, String.length(keyword)) == keyword do
      String.slice(string, String.length(keyword), String.length(string))
    else
      keyword_search!(body, keyword, curr+1)
    end
  end

  defp find_event_start!(body) do
    body
    |> Floki.find("div")
    |> keyword_search!("Start:",0)
  end

  defp find_event_end!(body) do
    body
    |> Floki.find("div")
    |> keyword_search!("End:",0)
  end

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

  defp find_event_name!(body) do
    body
    |> Floki.find(".eventheadline")
    |> Floki.text
  end

  defp find_event_type!(body) do
    body
    |> Floki.find(".ribbon-wrapper")
    |> Floki.text
  end
end
