defmodule Servy do
  def test do
    request = """
    GET /wildthings HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bigfoot HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /wildlife HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bears?id=1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bears?id=2 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    DELETE /bears/1 HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("<<<<<<<<<<<<<<>>>>>>>>>>>>>>")

    request = """
    GET /about HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    GET /bears/new HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*

    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("-------------------")

    request = """
    POST /bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/x-www-form-urlencoded
    Content-Length: 21

    name=Baloo&type=Brown
    """

    response = Servy.Handler.handle(request)
    IO.puts(response)
    IO.puts("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")

    # expected_response = """
    # HTTP/1.1 200 OK
    # Content-Type: text/html
    # Content-Length: 20

    # Bears, Lions, Tigers
    # """
  end
end
