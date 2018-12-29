defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear
  alias Servy.BearView

  # @templates_path Path.expand("templates", File.cwd!())

  # default bindings \\ [] to an empty list

  # def render(conv, template, bindings \\ []) do
  #   content =
  #     @templates_path
  #     |> Path.join(template)
  #     # /mnt/c/Users/maxhe/projets/servy/templates/((template))
  #     |> EEx.eval_file(bindings)

  #   %{conv | status: 200, resp_body: content}
  # end

  def index(conv) do
    # TODO: Transform bears to an  HTML list:
    # pipeline this with b as bear
    # join will return 1 big string
    # chg bears by items and plug it into the resp_body
    # add a filter (t/f) if true will go on  with the pipeline
    # add sort to sort the bears by their name

    # items =
    # Wildthings.list_bears()
    # |> Enum.filter(fn b -> Bear.is_grizzly(b) end)
    # |> Enum.sort(fn b1, b2 -> Bear.order_asc_by_name(b1, b2) end)
    # |> Enum.map(fn b -> bear_item(b) end)
    # %{conv | status: 200, resp_body: content}

    # |> Enum.filter(&Bear.is_grizzly(&1))
    # |> Enum.sort(&Bear.order_asc_by_name(&1, &2))
    # |> Enum.map(&bear_item(&1))

    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    # bindings = bears: bears
    # render(conv, "index.eex", bears: bears)
    %{conv | status: 200, resp_body: BearView.index(bears)}
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    # render(conv, "show.eex", bear: bear)
    %{conv | status: 200, resp_body: BearView.show(bear)}
  end

  # def create(conv, params) do
  def create(conv, %{"name" => name, "type" => type} = _params) do
    %{
      conv
      | status: 201,
        resp_body: "Create a #{type} bear named #{name}!"
    }
  end

  def delete(conv, _params) do
    %{conv | status: 403, resp_body: "Bears must never be deleted!"}
  end
end
