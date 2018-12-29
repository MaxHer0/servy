defmodule Servy.Plugins do
  alias Servy.Conv

  @doc "Add some emojis around the response"
  def emojify(%Conv{status: 200} = conv) do
    emojies = String.duplicate("🔱 ", 5)
    body = emojies <> "\n" <> conv.resp_body <> "\n" <> emojies

    %{conv | resp_body: body}
  end

  def emojify(%Conv{status: 201} = conv) do
    emojies = String.duplicate("📦  ", 5)
    body = emojies <> "\n" <> conv.resp_body <> "\n" <> emojies

    %{conv | resp_body: body}
  end

  def emojify(%Conv{status: 404} = conv) do
    emojies = String.duplicate("💀 ", 5)
    body = emojies <> "\n" <> conv.resp_body <> "\n" <> emojies

    %{conv | resp_body: body}
  end

  # run for the other staus => and return the conv
  def emojify(%Conv{} = conv), do: conv

  @doc """
    Logs 404 requests
    run only when status is 404 => capture the path => and return the conv
  """
  def track(%Conv{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} is on the loose!")
    conv
  end

  # skip the other status => return conv simply for the next pipe
  def track(%Conv{} = conv), do: conv

  # if path = wildlife => rewrite to wildthings
  def rewrite_path(%Conv{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conv{path: "/bears?id=" <> id} = conv) do
    %{conv | path: "/bears/#{id}"}
  end

  # for other path => return conv simply for the next pipe
  def rewrite_path(%Conv{} = conv), do: conv

  # def log(conv) do
  #   IO.inspect(conv)
  #   conv
  # end

  def log(%Conv{} = conv), do: IO.inspect(conv)
end
