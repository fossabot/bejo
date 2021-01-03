defmodule Bejo.Deploy do
  def copy_files(args) do
    path = "_build/#{Mix.env()}/rel/bakeware/bejo"

    File.cp!(path, "./bejo")
    IO.puts("Bejo executable available at #{File.cwd!()}/bejo")
    args
  end

  def set_env(args) do
    System.put_env("BEJO_RUN_CLI", "true")
    args
  end
end
