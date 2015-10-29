require Logger

defmodule Gnip do
  use Application
  import Gnip.Http

  def start(_, _) do end

  def main(args) do
    opts = parse_args(args)
    {user, pass} = get_config(opts[:network])
    url = get_url(opts[:network])

    Gnip.Http.get(url, user, pass)
    |> print_recursively
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [network: :string])
    options
  end

  defp get_config(network) do
    cond do
      network == "twitter" ->
        {:ok, user_pass} = Application.fetch_env(:logins, :powertrack)
      true ->
        {:ok, user_pass} = Application.fetch_env(:logins, :data_collector)
    end

    {user_pass[:user], user_pass[:pass]}
  end

  defp get_url(network) do
    {:ok, url} = Application.fetch_env(:urls, String.to_atom(network))
    url
  end

  defp pretty_print(val) do
    IO.puts "#{IO.ANSI.green}Rule: #{IO.ANSI.default_color}#{val["value"]}\n#{IO.ANSI.green}Tag: #{IO.ANSI.default_color}#{val["tag"]}\n"
  end

  defp print_recursively([head | tail]) do
    pretty_print head
    print_recursively tail
  end

  defp print_recursively([]) do
    #printing is done
  end
end
