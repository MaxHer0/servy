# Servy


**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `servy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:servy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/servy](https://hexdocs.pm/servy).

# servy

defmodule Recurse do
  def loopy([head | tail]) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"
    loopy(tail)
  end

  def loopy([]), do: IO.puts "Done!"
end

Recurse.loopy([1, 2, 3, 4, 5])
--------------------------------------------------------

defmodule Recurse do
  def sum([head | tail], total) do
    IO.puts "Total: #{total} Head: #{head} Tail: #{inspect(tail)}"
    sum(tail, total + head)
  end

  def sum([], total), do: total
end

IO.puts Recurse.sum([1, 2, 3, 4, 5], 0)
------------------------------------------------------

    defmodule Recurse do
      def triple([head | tail]) do
        [head * 3 | triple(tail)]
      end

      def triple([]), do: []
    end

    IO.inspect(Recurse.triple([1, 2, 3, 4, 5]))
-----------------------------------------------------

IO.puts(String.duplicate("🌮  ", 5))
    IO.puts(content)

---------------------------------------------------