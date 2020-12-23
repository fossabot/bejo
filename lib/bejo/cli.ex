defmodule Bejo.Cli do
  require Logger

  def main(args) do
    parse_args(args)
  end

  defp parse_args(["exec" | rest]) do
    options = [
      strict: [function: :string],
      aliases: [f: :function]
    ]

    {opts, rest} = OptionParser.parse!(rest, options)

    main_file = List.first(rest) || "main.bejo"
    function = opts[:function] || "main.start()"

    {:module, module} = Bejo.Code.load_file(main_file)
    Logger.debug "Calling :#{module}.#{function}"
    {result, _binding} = Code.eval_string(":\"#{module}\".#{function}")
    IO.inspect result
  end

  defp parse_args(["start" | rest]) do
    path = List.first(rest)
    case Bejo.start(path) do
      :ok -> :timer.sleep(:infinity)
      :error -> :error
    end
  end
end
