defmodule Supermarket.Cashier do
  alias Supermarket.Products
  require Supermarket.Constants
  import Supermarket.Constants

  def scan(bascet) do
    bascet
    |> Enum.map(&Products.get_product(&1))
    |> tea_discount
    |> strawb_discount
    |> coffee_discount
    |> get_price
  end

  defp get_price(items) do
    items
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> Float.round(2)
  end

  defp tea_discount(basket) do
    itemCount = Enum.count(basket, fn item -> item.id == green_tea_id() end)

    case itemCount >= 2 do
      true ->
        forFreeCount = trunc(itemCount / 2)
        del_from_basket(basket, 1, forFreeCount)

      false ->
        basket
    end
  end

  defp strawb_discount(basket) do
    itemCount = Enum.count(basket, fn item -> item.id == strawberry_id() end)

    case itemCount >= 3 do
      true ->
        Enum.map(basket, fn
          %{id: 2, price: price} = item -> %{item | price: price - 0.5}
          item -> item
        end)

      false ->
        basket
    end
  end

  defp coffee_discount(basket) do
    itemCount = Enum.count(basket, fn item -> item.id == coffee_id() end)

    case itemCount >= 3 do
      true ->
        Enum.map(basket, fn
          %{id: 3, price: price} = item -> %{item | price: price * 2 / 3}
          item -> item
        end)

      false ->
        basket
    end
  end

  defp del_from_basket(basket, _id, n) when n == 0 do
    basket
  end

  defp del_from_basket([h | t], id, n) when h.id == id do
    del_from_basket(t, id, n - 1)
  end

  defp del_from_basket([h | t], id, n) do
    h ++ del_from_basket(t, id, n - 1)
  end
end