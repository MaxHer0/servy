defmodule Servy.BearView do
  require EEx

  @moduledoc """
    It would be faster if we could do all the inefficient stuff once—in other words, precompile the template— and then run a function every time the route is called. Thankfully, the EEx module offers an easy way to do that, too! The EEx.function_from_file/5 macro generates a function definition from the file contents.

  Here's how you could use it in the context of our web server. Suppose we had a BearView module that called EEx.function_from_file to generate index and show functions for the index.eex and show.eex file contents respectively:
  """
  @templates_path Path.expand("templates", File.cwd!())

  EEx.function_from_file(:def, :index, Path.join(@templates_path, "index.eex"), [:bears])

  EEx.function_from_file(:def, :show, Path.join(@templates_path, "show.eex"), [:bear])
end
