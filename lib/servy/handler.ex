defmodule Servy.Handler do
  @moduledoc "Handles HTTP requests"

  alias Servy.Conv
  alias Servy.BearController

  # @constant
  # @pages_path Path.expand("../../pages", __DIR__)
  # ! ==> it raises an exception if for some reason there's a problem
  # File.cwd! ==> current working directory
  @pages_path Path.expand("pages", File.cwd!())

  import Servy.Parser
  import Servy.FileHandler
  import Servy.Plugins, only: [emojify: 1, rewrite_path: 1, log: 1, track: 1]

  @doc "Transforms the request into a response"
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # format_response(conv)

    request
    |> parse
    |> rewrite_path
    |> log
    |> route
    |> emojify
    |> track
    |> format_response
  end

  # def route(conv) do
  #   route(conv, conv.method, conv.path)
  # end

  # transfort that map into a new map
  # def route(conv, "GET", "/wildthings") do
  #   # TODO: Route create a new map that has also the response body
  #   # conv = %{methode: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
  #   %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  # end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  # def route(conv, "GET", "/bears") do
  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    # %{conv | status: 200, resp_body: "Teddy, Yogi, Balou"} \\ cut paste in index fn
    BearController.index(conv)
  end

  def route(%Conv{method: "GET", path: "/bears/new"} = conv) do
    @pages_path
    |> Path.join("form.html")
    |> File.read()
    |> handle_file(conv)
  end

  # <> pour add 1 a la string path
  # def route(conv, "GET", "/bears/" <> id) do
  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    # %{conv | status: 200, resp_body: "Bear #{id}"}
    # BearController.show(conv, id)
    params = Map.put(conv.params, "id", id)
    BearController.show(conv, params)
  end

  # name=Baloo&type=Brown
  # def route(%Conv{method: "POST", path: "/bears"} = conv) do
  #   params = %{"name" => "Baloo", "type" => "Brown"}
  #   %{conv | status: 201, resp_body: "Create a #{params["type"]} bear named #{params["name"]}!"}
  # end
  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    # %{
    #   conv
    #   | status: 201,
    #     resp_body: "Create a #{conv.params["type"]} bear named #{conv.params["name"]}!"
    # }
    BearController.create(conv, conv.params)
  end

  # def route(conv, "DELETE", "/bears/" <> _id) do
  #   %{ conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  # End

  # def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
  #   %{conv | status: 403, resp_body: "Bears must never be deleted!"}
  # end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    BearController.delete(conv, conv.params)
  end

  # ../../ because 2x directories up vs handler.ex
  # def route(%{method: "GET", path: "/about"} = conv) do
  #   # # to define the absolute dir of the file
  #   # pages_path = Path.expand("../../pages", __DIR__)
  #   # # to join on the actual file
  #   # file = Path.join(pages_path, "about.html")
  #   file =
  #     Path.expand("../../pages", __DIR__)
  #     |> Path.join("about.html")

  #   # "pages/about.html" ==> file
  #   case File.read(file) do
  #     {:ok, content} ->
  #       %{conv | status: 200, resp_body: content}

  #     {:error, :enoent} ->
  #       %{conv | status: 404, resp_body: "File not found!"}

  #     {:error, reason} ->
  #       %{conv | status: 500, resp_body: "File error: #{reason}"}
  #   end

  #   # %{conv | status: 200, resp_body: "contents of file"}
  # end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    # file =
    Path.expand("../../pages", __DIR__)
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)
  end

  # def route(conv, _method, path) do
  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, resp_body: "No #{path} here!"}
  end

  def format_response(%Conv{} = conv) do
    # TODO: Use values in the map to ceate an HTTP response string
    # """
    # HTTP/1.1 200 OK
    # Content-Type: text/html
    # Content-Length: 20

    # Bears, Lions, Tigers
    # """
    """
    HTTP/1.1 #{Conv.full_status(conv)}\r
    Content-Type: text/html\r
    Content-Length: #{String.length(conv.resp_body)}\r
    \r
    #{conv.resp_body}
    """
  end
end
