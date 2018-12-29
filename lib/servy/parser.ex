defmodule Servy.Parser do
  # alias Servy.Conv, as: Conv
  alias Servy.Conv

  # transfort a request string into a key value pair
  def parse(request) do
    # todo: Parse the resquest string into a map:
    # con versation between the server and the browser

    # first_line = request |> String.split("\n")|> List.first()
    # [methode, path, _] = String.split(first_line, " ")
    # conv = %{methode: "GET", path: "/wildthings", resp_body: ""}

    # now splitting the request into 2 lines to get the params from the body
    # top for the request line (POST...) and params_string for the last line: params
    # the header lines between top and params will be set as a list of strings
    [top, params_string] = String.split(request, "\r\n\r\n")

    [request_line | header_lines] = String.split(top, "\r\n")

    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines, %{})

    # IO.inspect(header_lines)

    params = parse_params(headers["Content-Type"], params_string)

    # %{method: method, path: path, resp_body: ""}
    # intialize the struct here... rest of the code works map = conv... conv is a map structured
    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers

  @doc """
  decode the params string into a map with corresponding keys and values.

  ## Examples
  iex> params_strings = "name=Baloo&type=Brown"
  iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", params_strings)
  %{"name" => "Baloo", "type" => "Brown"}
  iex> Servy.Parser.parse_params("multipart/form-data", params_strings)
  %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}
end
