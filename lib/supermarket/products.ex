defmodule Supermarket.Products do
  @products %{
    "GR1" => %{id: 1, name: "Green tea", price: 3.11},
    "SR1" => %{id: 2, name: "Strawberries", price: 5.00},
    "CF1" => %{id: 3, name: "Coffee", price: 11.23}
  }

  def get_product(code), do: Map.get(@products, code)
end