defmodule HandlerTest do
  use ExUnit.Case
  # doctest Servy

  import Servy.Handler, only: [handle: 1]

  test "GET /wildthings" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert response =~ """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 42\r
           \r
           🔱 🔱 🔱 🔱 🔱
           Bears, Lions, Tigers
           🔱 🔱 🔱 🔱 🔱
           """
  end

  test "GET /wildthings_old" do
    request = """
    GET /wildthings HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    assert handle(request) == """
           HTTP/1.1 200 OK\r
           Content-Type: text/html\r
           Content-Length: 42\r
           \r
           🔱 🔱 🔱 🔱 🔱
           Bears, Lions, Tigers
           🔱 🔱 🔱 🔱 🔱
           """
  end

  test "GET /bears" do
    request = """
    GET /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    response = handle(request)

    # ici single ou double? pour expected_response:? single why? on compare, on compare rien en fait on veut juste assigne la valeur a expected_response right?  si tu fatais double, il comprable, single il assign la valuer . oui dans ma tete jetais rendu a lquation plus loin ou on compare, au assertt ici... je vois pas ton assert? javais pas fini ;) ha I see, let go up then
    expected_response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: 380\r
    \r
    🔱 🔱 🔱 🔱 🔱
    <h1>All The Bears!</h1>

    <ul>
    <li>Brutus - Grizzly</li>
    <li>Iceman - Polar</li>
    <li>Kenai - Grizzly</li>
    <li>Paddington - Brown</li>
    <li>Roscoe - Panda</li>
    <li>Rosie - Black</li>
    <li>Scarface - Grizzly</li>
    <li>Smokey - Black</li>
    <li>Snow - Polar</li>
    <li>Teddy - Brown</li>
    </ul>
    🔱 🔱 🔱 🔱 🔱
    """
  end
end
