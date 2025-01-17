defmodule Supermarket.Cashier do
  alias Supermarket.Products
  require Supermarket.Constants
  import Supermarket.Constants

  @spec do_scan([String.t()], boolean()) :: float()
  def do_scan(basket, isGoodCust \\ true) do
    scan(basket, isGoodCust)
  end

  @spec scan([String.t()], boolean()) :: float()
  defp scan(basket, isGoodCust) do
    case isGoodCust do
      true ->
        basket
        |> Enum.map(&Products.get_product(&1))
        |> tea_discount()
        |> strawb_discount()
        |> coffee_discount()
        |> get_price()

      false ->
        basket
        |> Enum.map(&Products.get_product(&1))
        |> get_price()
    end
  end

  @spec get_price([%{price: float()}]) :: float()
  defp get_price(items) do
    items
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> Float.round(2)
  end

  @spec tea_discount([%{id: integer()}]) :: [%{id: integer()}]
  defp tea_discount(basket) do
    itemCount = Enum.count(basket, &(&1.id == green_tea_id()))

    case itemCount >= 2 do
      true ->
        forFreeCount = trunc(itemCount / 2)
        del_from_basket(basket, 1, forFreeCount)

      false ->
        basket
    end
  end

  @spec strawb_discount([%{id: integer()}]) :: [%{id: integer()}]
  defp strawb_discount(basket) do
    itemCount = Enum.count(basket, &(&1.id == strawberry_id()))

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

  @spec coffee_discount([%{id: integer()}]) :: [%{id: integer()}]
  defp coffee_discount(basket) do
    itemCount = Enum.count(basket, &(&1.id == coffee_id()))

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

  @spec del_from_basket([%{id: integer()}], integer(), integer()) :: [%{id: integer()}]
  defp del_from_basket(basket, _id, n) when n == 0, do: basket

  @spec del_from_basket([%{id: integer()}], integer(), integer()) :: [%{id: integer()}]
  defp del_from_basket([h | t], id, n) when h.id == id, do: del_from_basket(t, id, n - 1)

  @spec del_from_basket([%{id: integer()}], integer(), integer()) :: [%{id: integer()}]
  defp del_from_basket([h | t], id, n), do: [h | del_from_basket(t, id, n - 1)]
end