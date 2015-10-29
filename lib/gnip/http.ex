defmodule Gnip.Http do
  use HTTPoison.Base
  alias Poison, as: JSON

  def get(url, user, pass) do
    auth = [basic_auth: {user, pass}]
    result = HTTPoison.get!(url, [], [hackney: auth])
    %HTTPoison.Response{status_code: status_code, body: body} = result

    rules = JSON.decode! body
    rules["rules"]
  end
end
