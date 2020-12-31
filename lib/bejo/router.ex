defmodule Bejo.Router do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    {status, resp} = get_resp(conn.method, conn.request_path)
    send_resp(conn, status, resp)
  end

  def home do
    "It's bejo time!"
  end

  defp get_resp(method, path) do
    case Bejo.RouteStore.get_route(method, path) do
      nil -> {404, "Not found"}
      function ->
        body = function.()
        {200, body}
    end
  end
end
