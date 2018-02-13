defmodule ExplorerWeb.AddressController do
  use ExplorerWeb, :controller

  import Ecto.Query

  alias Explorer.Address
  alias Explorer.AddressForm
  alias Explorer.Repo.NewRelic, as: Repo

  def show(conn, params) do
    hash = String.downcase(params["id"])
    query = from address in Address,
      where: fragment("lower(?)", address.hash) == ^hash,
      limit: 1

    address = Repo.one(query)
    render(conn, "show.html", address: AddressForm.build(address))
  end
end