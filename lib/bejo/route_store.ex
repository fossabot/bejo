defmodule Bejo.RouteStore do
  use Agent

  require Logger

  def start_link(_) do
    Agent.start_link(fn -> load_routes() end, name: __MODULE__)
  end

  def get_route(method, path) do
    Agent.get(__MODULE__, fn routes ->
      routes["#{method}:#{path}"]
    end)
  end

  def load_routes do
    Bejo.Code.load_file("router.bejo")

    if function_exported?(:router, :routes, 0) do
      routes = :router.routes()
      Enum.into(routes, %{}, fn [method, path, function] ->
          {"#{method}:#{path}", {:router, str_to_atom(function)}}
      end)
    else
      Logger.error "Router has no function routes/0"
      %{}
    end
  end

  def put_routes(routes) do
    Agent.update(__MODULE__, fn _routes ->
      routes
    end)
  end

  def reload_routes do
    load_routes()
    |> put_routes()
  end

  def list_routes do
    Agent.get(__MODULE__, fn routes -> routes end)
  end

  defp str_to_atom(str) do
    str
    |> to_string()
    |> String.to_atom()
  end
end
