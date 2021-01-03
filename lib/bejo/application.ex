defmodule Bejo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children =
      if Application.get_env(:bejo, :start_cli) do
        [%{id: Bejo.Cli, start: {Bejo.Cli, :start, [nil, nil]}}]
      else
        []
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bejo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
